import Combine

public protocol Router {
    var route: PassthroughSubject<any RoutePath, Never> { get }
    var initialPath: any RoutePath { get }
}

extension Router {
    var initialPath: any RoutePath {
        NoneRoutePath()
    }
}
