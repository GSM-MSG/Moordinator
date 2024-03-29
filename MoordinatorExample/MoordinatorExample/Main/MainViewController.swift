import UIKit
import Combine
import Moordinator

final class MainViewController: UIViewController, Router {
    var route: PassthroughSubject<any RoutePath, Never> = .init()
    private let button = UIButton()
    var bag = Set<AnyCancellable>()

    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.addSubview(button)
        button.setTitle("toSub", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
    }
    
    @objc func buttonDidTap(_ sender: UIButton) {
        self.route.send(ExRoutePath.sub)
    }
}
