import UIKit

final class SourceCurrencyListViewController: UIViewController {
    // MARK: UI Components
    private var label: UILabel = {
        let label = UILabel()
        label.text = "Hello World"
        label.font = .boldSystemFont(ofSize: 50)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var contentView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.layoutMargins = .init(top: 16, left: 16, bottom: 16, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: ViewModels
    private var viewModel: SourceCurrencyListViewModel
    
    init(viewModel: SourceCurrencyListViewModel = .init()) {
        self.viewModel = viewModel
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
        title = "Convert from"
        view.backgroundColor = .white
        setupComponents()
        setupNavigationBar()
        setupConstraints()
    }
    
    func setupComponents() {
        view.addSubview(contentView)
        viewModel.items.forEach { currency in
            let currencyView = SourceCurrencyView(currency: currency)
            currencyView.delegate = self
            contentView.addArrangedSubview(currencyView)
        }
    }
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = .init(
            title: "History",
            primaryAction: UIAction { [weak self] _ in
                self?.openHistory()
            }
        )
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
    
    func openHistory() {
        
    }
}

extension SourceCurrencyListViewController: SourceCurrencyViewDelegate {
    func didSelectSource(currency: CurrencySymbol) {
        dump(currency)
    }
}

#Preview {
    UINavigationController(rootViewController: SourceCurrencyListViewController())
}
