import Moordinator
import Combine
import UIKit

final class MainMoordinator: Moordinator {
    private let rootVC = UINavigationController()

    var root: Presentable {
        rootVC
    }

    func route(to path: any RoutePath) -> MoordinatorContributors {
        guard let path = path as? ExRoutePath else { return .none }
        switch path {
        case .main:
            let vc = MainViewController()
            rootVC.setViewControllers([vc], animated: true)
            return .one(.contribute(withNextPresentable: vc, withNextRouter: vc))

        case .sub:
            return .one(.forwardToParent(with: ExRoutePath.sub))

        default:
            return .none
        }
        return .none
    }
}
