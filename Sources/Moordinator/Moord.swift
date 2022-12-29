import UIKit

public struct Moord {
    public static func use<Root>(
        _ moordinator: any Moordinator,
        block: @escaping (_ root: Root) -> Void
    ) where Root: UIViewController {
        guard let root = moordinator.root as? Root else {
            fatalError("The Root type does not match moordinator's root")
        }
        block(root)
    }
}
