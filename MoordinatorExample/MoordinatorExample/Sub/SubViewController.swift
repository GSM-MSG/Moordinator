import UIKit
import Combine
import Moordinator

final class SubViewController: UIViewController, Router {
    var route: PassthroughSubject<any RoutePath, Never> = .init()
    private let mainButton = UIButton()
    private let detailButton = UIButton()
    var bag = Set<AnyCancellable>()

    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        view.addSubview(mainButton)
        mainButton.setTitle("toMain", for: .normal)
        mainButton.translatesAutoresizingMaskIntoConstraints = false
        mainButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        mainButton.addTarget(self, action: #selector(mainButtonDidTap), for: .touchUpInside)

        view.addSubview(detailButton)
        detailButton.setTitle("toDetail", for: .normal)
        detailButton.translatesAutoresizingMaskIntoConstraints = false
        detailButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        detailButton.topAnchor.constraint(equalTo: mainButton.bottomAnchor, constant: 20).isActive = true
        detailButton.addTarget(self, action: #selector(detailButtonDidTap), for: .touchUpInside)
    }
    
    @objc func mainButtonDidTap(_ sender: UIButton) {
        self.route.send(ExRoutePath.main)
    }
    @objc func detailButtonDidTap(_ sender: UIButton) {
        self.route.send(ExRoutePath.subDetail)
    }
}
