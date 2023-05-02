import Combine

public final class DefaultRouter: Router {
    public var route: PassthroughSubject<any RoutePath, Never> = .init()
    
    public init() {}
}
