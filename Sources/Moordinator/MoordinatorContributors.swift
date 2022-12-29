import UIKit

public enum MoordinatorContributors {
    case one(MoordinatorContributor)
    case multiple([MoordinatorContributor])
    case end(any RoutePath)
    case none
}
