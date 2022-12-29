import Moordinator
import Combine
import UIKit

final class MainMoordinator: Moordinator {
    private let rootVC = UINavigationController()
    let router: any Router = MainRouter()

    var root: Presentable {
        rootVC
    }

    func route(to path: RoutePath) -> MoordinatorContributors {
        guard let path = path as? ExRoutePath else { return .none }
        switch path {
        case .main:
            let vc = MainViewController(router: router)
            rootVC.setViewControllers([vc], animated: true)

        case .sub:
            return .one(.forwardToParent(with: ExRoutePath.sub))

        default:
            return .none
        }
        return .none
    }
}
