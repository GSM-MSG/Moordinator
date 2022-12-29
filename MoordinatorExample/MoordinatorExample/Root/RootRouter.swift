import Moordinator
import Combine

final class RootRouter: Router {
    var route: PassthroughSubject<any RoutePath, Never> = .init()
    var initialPath: any RoutePath {
        ExRoutePath.main
    }
}
