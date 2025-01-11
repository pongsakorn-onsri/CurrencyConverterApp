import UIKit

final class SourceCurrencyListViewController: UIViewController {
    // MARK: UI Components
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
            let currencyView = CurrencyView(currency: currency)
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
        let controller = HistoryListViewController()
        controller.delegate = self
        showDetailViewController(controller, sender: nil)
    }
}

extension SourceCurrencyListViewController: CurrencyViewDelegate {
    func didSelectSource(currency: CurrencySymbol) {
        let controller = DestinationCurrencyListController(viewModel: .init(sourceCurrency: currency))
        navigationController?.show(controller, sender: nil)
    }
}

extension SourceCurrencyListViewController: HistoryListViewControllerDelegate {
    func didSelectHistory(item: HistoryItem) {
        dismiss(animated: true) {
            let controller = CurrencyConversionController(
                viewModel: CurrencyConversionViewModelImpl(
                    source: item.source,
                    destination: item.destination,
                    rate: item.rate
                )
            )
            self.show(controller, sender: nil)
        }
    }
}

#Preview {
    UINavigationController(rootViewController: SourceCurrencyListViewController())
}
