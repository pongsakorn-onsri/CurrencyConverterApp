import UIKit

final class DestinationCurrencyListController: UIViewController {
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
    private var viewModel: DestinationCurrencyListViewModel
    
    init(viewModel: DestinationCurrencyListViewModel = .init(sourceCurrency: .USD)) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        Task {
            try await viewModel.fetchCurrencyRates()
            refreshViews()
        }
    }
}

private extension DestinationCurrencyListController {
    func setupViews() {
        title = "1 \(viewModel.sourceCurrency.rawValue) ="
        view.backgroundColor = .white
        setupComponents()
        setupNavigationBar()
        setupConstraints()
    }
    
    func setupComponents() {
        view.addSubview(contentView)
        viewModel.items.forEach { item in
            let currencyView = CurrencyView(currency: item.symbol)
            currencyView.delegate = self
            if let rate = item.rate {
                currencyView.bind(rate: rate)
            }
            contentView.addArrangedSubview(currencyView)
        }
    }
    
    func refreshViews() {
        contentView.subviews
            .forEach { view in
                guard let CurrencyView = view as? CurrencyView else { return }
                if let rate = viewModel.getRate(currency: CurrencyView.currency) {
                    CurrencyView.bind(rate: rate)
                }
            }
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
}

extension DestinationCurrencyListController: CurrencyViewDelegate {
    func didSelectSource(currency: CurrencySymbol) {
        dump(currency)
    }
}

#Preview {
    UINavigationController(rootViewController: DestinationCurrencyListController())
}
