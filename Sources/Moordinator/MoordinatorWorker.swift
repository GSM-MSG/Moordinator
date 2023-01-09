import UIKit
import Combine

public final class MoordinatorWorker {
    private let id = UUID().uuidString
    private var bag = Set<AnyCancellable>()
    private var childMoordinatorWorker: [String: MoordinatorWorker] = [:]
    private weak var parentMoordinatorWorker: MoordinatorWorker?
    private let route = PassthroughSubject<RoutePath, Never>()

    public init() {}

    public func coordinate(moordinator: any Moordinator) {
        self.route
            .append(Publishers.Merge(moordinator.router.route, route))
            .receive(on: RunLoop.main)
            .map { moordinator.route(to: $0) }
            .sink { [weak self] contributors in
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
            }
            .store(in: &bag)
        
        moordinator.router.route
            .sink { [weak self] route in
                self?.route.send(route)
            }
            .store(in: &bag)

        Just(moordinator.router.initialPath)
            .sink { [weak self] route in
                self?.route.send(route)
            }
            .store(in: &bag)
    }

    private func performSideEffect(contributor: MoordinatorContributor) {
        switch contributor {
        case let .contribute(presentable):
            if let childMoordinator = presentable as? Moordinator {
                let worker = MoordinatorWorker()
                worker.parentMoordinatorWorker = self
                self.childMoordinatorWorker[worker.id] = worker
                worker.coordinate(moordinator: childMoordinator)
            }

        case let .forward(path):
            self.route.send(path)

        case let .forwardToParent(path):
            self.parentMoordinatorWorker?.route.send(path)
        }
    }
}
