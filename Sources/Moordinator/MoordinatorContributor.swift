import UIKit

public enum MoordinatorContributor {
    case contribute(
        withNextPresentable: any Presentable,
        withNextRouter: any Router = DefaultRouter()
    )
    case forward(with: any RoutePath)
    case forwardToParent(with: any RoutePath)
}
