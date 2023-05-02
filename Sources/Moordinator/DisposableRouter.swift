import Combine

public final class DisposableRouter: Router {
    public var route: PassthroughSubject<any RoutePath, Never> = .init()
    
    public var initialPath: any RoutePath {
        singlePath
    }
    private let singlePath: any RoutePath


    public init(singlePath: any RoutePath) {
        self.singlePath = singlePath
    }
}
