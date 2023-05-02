import Combine
import UIKit
import Moordinator

final class SubDetailViewController: UIViewController, Router {
    var route: PassthroughSubject<any RoutePath, Never> = .init()
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}
