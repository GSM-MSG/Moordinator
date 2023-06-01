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

    public static func use<Root1, Root2>(
        _ moordinator1: any Moordinator,
        _ moordinator2: any Moordinator,
        block: @escaping (_ root1: Root1, _ root2: Root2) -> Void
    ) where Root1: UIViewController, Root2: UIViewController {
        guard
            let root1 = moordinator1.root as? Root1,
            let root2 = moordinator2.root as? Root2
        else {
            fatalError("The Root type does not match moordinator's root")
        }
        block(root1, root2)
    }

    public static func use<Root1, Root2, Root3>(
        _ moordinator1: any Moordinator,
        _ moordinator2: any Moordinator,
        _ moordinator3: any Moordinator,
        block: @escaping (_ root1: Root1, _ root2: Root2, _ root3: Root3) -> Void
    ) where Root1: UIViewController, Root2: UIViewController, Root3: UIViewController {
        guard
            let root1 = moordinator1.root as? Root1,
            let root2 = moordinator2.root as? Root2,
            let root3 = moordinator3.root as? Root3
        else {
            fatalError("The Root type does not match moordinator's root")
        }
        block(root1, root2, root3)
    }

    public static func use<Root1, Root2, Root3, Root4>(
        _ moordinator1: any Moordinator,
        _ moordinator2: any Moordinator,
        _ moordinator3: any Moordinator,
        _ moordinator4: any Moordinator,
        block: @escaping (_ root1: Root1, _ root2: Root2, _ root3: Root3, _ root4: Root4) -> Void
    )
    where
        Root1: UIViewController,
        Root2: UIViewController,
        Root3: UIViewController,
        Root4: UIViewController {
        guard
            let root1 = moordinator1.root as? Root1,
            let root2 = moordinator2.root as? Root2,
            let root3 = moordinator3.root as? Root3,
            let root4 = moordinator4.root as? Root4
        else {
            fatalError("The Root type does not match moordinator's root")
        }
        block(root1, root2, root3, root4)
    }

    public static func use<Root1, Root2, Root3, Root4, Root5>(
        _ moordinator1: any Moordinator,
        _ moordinator2: any Moordinator,
        _ moordinator3: any Moordinator,
        _ moordinator4: any Moordinator,
        _ moordinator5: any Moordinator,
        block: @escaping (_ root1: Root1, _ root2: Root2, _ root3: Root3, _ root4: Root4, _ root5: Root5) -> Void
    ) where Root1: UIViewController,
            Root2: UIViewController,
            Root3: UIViewController,
            Root4: UIViewController,
            Root5: UIViewController {
        guard
            let root1 = moordinator1.root as? Root1,
            let root2 = moordinator2.root as? Root2,
            let root3 = moordinator3.root as? Root3,
            let root4 = moordinator4.root as? Root4,
            let root5 = moordinator5.root as? Root5
        else {
            fatalError("The Root type does not match moordinator's root")
        }
        block(root1, root2, root3, root4, root5)
    }

    public static func use(
        _ moordinators: [some Moordinator],
        block: @escaping (_ roots: [UIViewController]) -> Void
    ) {
        let roots = moordinators
            .compactMap { $0.root as? UIViewController }
        block(roots)
    }
}
