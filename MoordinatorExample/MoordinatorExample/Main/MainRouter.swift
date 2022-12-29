import Combine
import Moordinator

final class MainRouter: Router {
    var route: PassthroughSubject<any RoutePath, Never> = .init()
    var initialPath: any RoutePath {
        ExRoutePath.main
    }
}
