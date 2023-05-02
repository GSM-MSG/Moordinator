import Combine
import Moordinator
import UIKit

final class RootMoordinator: Moordinator {
    private let window: UIWindow
    private lazy var rootVC: UIViewController = {
        let launchScreenStoryboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
        let launchScreen = launchScreenStoryboard.instantiateViewController(withIdentifier: "LaunchScreen")
        return launchScreen
    }()

    var root: Presentable {
        rootVC
    }

    init(window: UIWindow) {
        self.window = window
        window.rootViewController = rootVC
        window.makeKeyAndVisible()
    }

    func route(to path: any RoutePath) -> MoordinatorContributors {
        guard let path = path as? ExRoutePath else { return .none }
        switch path {
        case .main:
            let mainMoordinator = MainMoordinator()
            Moord.use(mainMoordinator) { root in
                self.window.rootViewController = root
                UIView.transition(
                    with: self.window,
                    duration: 0.3,
                    options: .transitionCrossDissolve,
                    animations: nil,
                    completion: nil
                )
            }
            return .one(.contribute(
                withNextPresentable: mainMoordinator,
                withNextRouter: DisposableRouter(singlePath: ExRoutePath.main)
            ))

        case .sub:
            let subMoordinator = SubMoordinator()
            Moord.use(subMoordinator) { root in
                self.window.rootViewController = root
                UIView.transition(
                    with: self.window,
                    duration: 0.3,
                    options: .transitionCrossDissolve,
                    animations: nil,
                    completion: nil
                )
            }
            return .one(.contribute(
                withNextPresentable: subMoordinator,
                withNextRouter: DisposableRouter(singlePath: ExRoutePath.sub)
            ))
            
        default:
            return .none
        }
        return .none
    }
}
