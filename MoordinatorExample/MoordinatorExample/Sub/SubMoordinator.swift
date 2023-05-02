import Moordinator
import Combine
import UIKit

final class SubMoordinator: Moordinator {
    private let rootVC = UINavigationController()

    var root: Presentable {
        rootVC
    }

    func route(to path: any RoutePath) -> MoordinatorContributors {
        guard let path = path as? ExRoutePath else { return .none }
        switch path {
        case .sub:
            let vc = SubViewController()
            rootVC.setViewControllers([vc], animated: true)
            return .one(.contribute(withNextPresentable: vc, withNextRouter: vc))

        case .subDetail:
            let vc = SubDetailViewController()
            rootVC.pushViewController(vc, animated: true)
            return .one(.contribute(withNextPresentable: vc, withNextRouter: vc))

        case .main:
            return .one(.forwardToParent(with: ExRoutePath.main))

        default:
            return .none
        }
        return .none
    }
}
