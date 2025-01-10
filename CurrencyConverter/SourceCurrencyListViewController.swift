import UIKit

final class SourceCurrencyListViewController: UIViewController {
    
    private var label: UILabel = {
        let label = UILabel()
        label.text = "Hello World"
        label.font = .boldSystemFont(ofSize: 50)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

private extension SourceCurrencyListViewController {
    func setupViews() {
        view.backgroundColor = .white
        setupComponents()
        setupConstraints()
    }
    
    func setupComponents() {
        view.addSubview(label)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

#Preview {
    SourceCurrencyListViewController()
}
