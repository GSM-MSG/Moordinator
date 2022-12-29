import Combine
import Moordinator

final class SubRouter: Router {
    var route: PassthroughSubject<any RoutePath, Never> = .init()
    var initialPath: any RoutePath {
        ExRoutePath.sub
    }
}
