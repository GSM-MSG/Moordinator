import UIKit

public protocol Moordinator: Presentable {
    var root: Presentable { get }
    var router: any Router { get }

    func route(to path: any RoutePath) -> MoordinatorContributors
}
