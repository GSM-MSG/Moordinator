import UIKit

public protocol Moordinator: Presentable {
    var root: Presentable { get }

    func route(to path: any RoutePath) -> MoordinatorContributors
}
