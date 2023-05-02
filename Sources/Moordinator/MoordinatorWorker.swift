import UIKit
import Combine

public final class MoordinatorWorker {
    private let id = UUID().uuidString
    private var bag = Set<AnyCancellable>()
    private var childMoordinatorWorker: [String: MoordinatorWorker] = [:]
    private weak var parentMoordinatorWorker: MoordinatorWorker?
    private let route = PassthroughSubject<any RoutePath, Never>()

    public init() {}

    public func coordinate(
        moordinator: any Moordinator,
        with router: any Router = DefaultRouter()
    ) {
        self.route
            .append(Publishers.Merge(router.route, route))
            .receive(on: RunLoop.main)
            .map { moordinator.route(to: $0) }
            .handleEvents(receiveOutput: { [weak self] contributors in
                switch contributors {
                case .none:
                    return

                case let .one(contributor):
                    self?.performSideEffect(contributor: contributor)

                case let .multiple(contributorList):
                    contributorList.forEach { self?.performSideEffect(contributor: $0) }

                case let .end(path):
                    self?.parentMoordinatorWorker?.route.send(path)
                    self?.childMoordinatorWorker.removeAll()
                    self?.parentMoordinatorWorker?
                        .childMoordinatorWorker
                        .removeValue(forKey: self?.id ?? "")
                }
            })
            .map { [weak self] in self?.nextRouters(from: $0) ?? [] }
            .flatMap { $0.publisher.eraseToAnyPublisher() }
            .flatMap { [weak self] in self?.steps(from: $0) ?? Empty().eraseToAnyPublisher() }
            .sink { [weak self] path in
                self?.route.send(path)
            }
            .store(in: &bag)
        
        router.route
            .sink { [weak self] route in
                self?.route.send(route)
            }
            .store(in: &bag)

        Just(router.initialPath)
            .sink { [weak self] route in
                self?.route.send(route)
            }
            .store(in: &bag)
    }
}

private extension MoordinatorWorker {
    private func performSideEffect(contributor: MoordinatorContributor) {
        switch contributor {
        case let .contribute(presentable, router):
            if let childMoordinator = presentable as? Moordinator {
                let worker = MoordinatorWorker()
                worker.parentMoordinatorWorker = self
                self.childMoordinatorWorker[worker.id] = worker
                worker.coordinate(moordinator: childMoordinator, with: router)
            }

        case let .forward(path):
            self.route.send(path)

        case let .forwardToParent(path):
            self.parentMoordinatorWorker?.route.send(path)
        }
    }

    private func nextRouters(from contributors: MoordinatorContributors) -> [any Router] {
        switch contributors {
        case let .one(.contribute(_, router)):
            return [router]

        case let .multiple(moordinatorContributors):
            return moordinatorContributors.compactMap {
                if case let .contribute(_, router) = $0 {
                    return router
                }
                return nil
            }

        default:
            return []
        }
    }

    private func steps(from router: any Router) -> AnyPublisher<any RoutePath, Never> {
        router.route
            .filter { !($0 is NoneRoutePath) }
            .eraseToAnyPublisher()
    }
}
