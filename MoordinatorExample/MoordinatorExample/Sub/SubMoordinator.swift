import Moordinator
import Combine
import UIKit

final class SubMoordinator: Moordinator {
    private let rootVC = UINavigationController()
    let router: any Router = SubRouter()

    var root: Presentable {
        rootVC
    }

    func route(to path: RoutePath) -> MoordinatorContributors {
        guard let path = path as? ExRoutePath else { return .none }
        switch path {
        case .sub:
            let vc = SubViewController(router: router)
            rootVC.setViewControllers([vc], animated: true)

        case .subDetail:
            let vc = SubDetailViewController(router: router)
            rootVC.pushViewController(vc, animated: true)

        case .main:
            return .one(.forwardToParent(with: ExRoutePath.main))

        default:
            return .none
        }
        return .none
    }
}
