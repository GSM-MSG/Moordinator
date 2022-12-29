import UIKit

public enum MoordinatorContributor {
    case contribute(any Presentable)
    case forward(with: any RoutePath)
    case forwardToParent(with: any RoutePath)
}
