import Combine
import Moordinator

struct AppRouter: Router {
    var route: PassthroughSubject<any RoutePath, Never> = .init()
    var initialPath: any RoutePath {
        ExRoutePath.main
    }
}
