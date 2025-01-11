import UIKit
import Combine

final class CurrencyConversionController: UIViewController {
    // MARK: UI Components
    private lazy var sourceAmountView = InputAmountView()
    private lazy var destinationAmountView = InputAmountView()
    
    private var arrowDownImageView: UIImageView = {
        let image = UIImage(systemName: "arrowshape.down.fill")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        return imageView
    }()

    private lazy var summaryButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.configuration?.title = "Summary"
        button.configuration?.titlePadding = 8
        button.configuration?.baseBackgroundColor = .systemMint
        button.configuration?.buttonSize = .large
        button.isEnabled = false
        return button
    }()
    
    private lazy var contentView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            sourceAmountView,
            arrowDownImageView,
            destinationAmountView,
            summaryButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.layoutMargins = .init(top: 16, left: 16, bottom: 16, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: ViewModels
    private var viewModel: CurrencyConversionViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: CurrencyConversionViewModel = CurrencyConversionViewModelImpl()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        sourceAmountView.textField.becomeFirstResponder()
    }
}

private extension CurrencyConversionController {
    func setupViews() {
        setupStyle()
        setupComponents()
        setupNavigationBar()
        setupConstraints()
        setupActions()
        setupBinding()
    }
    
    func setupStyle() {
        view.backgroundColor = .white
        sourceAmountView.textField.placeholder = "Source Amount"
        destinationAmountView.textField.placeholder = "Destination Amount"
    }
    
    func setupComponents() {
        view.addSubview(contentView)
    }
    
    func setupNavigationBar() {
        title = "1 \(viewModel.sourceSymbol) = \(viewModel.rate) \(viewModel.destinationSymbol)"
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
    
    func setupActions() {
        let sourceAmountPublisher = NotificationCenter.default.publisher(
            for: UITextField.textDidChangeNotification,
            object: sourceAmountView.textField
        )
        
        sourceAmountPublisher
            .compactMap { $0.object as? UITextField }
            .map(\.text)
            .receive(on: RunLoop.main)
            .sink { [weak self] text in
                guard let self, sourceAmountView.textField.isFirstResponder else { return }
                guard let text, !text.isEmpty else {
                    destinationAmountView.textField.text = ""
                    return
                }
                do {
                    sourceAmountView.update(error: nil)
                    let destinationAmount = try viewModel.input(sourceAmount: text)
                    destinationAmountView.textField.text = destinationAmount
                } catch {
                    sourceAmountView.update(error: error)
                }
            }
            .store(in: &cancellables)
        
        let destinationAmountPublisher = NotificationCenter.default.publisher(
            for: UITextField.textDidChangeNotification,
            object: destinationAmountView.textField
        )
        
        destinationAmountPublisher
            .compactMap { $0.object as? UITextField }
            .map(\.text)
            .receive(on: RunLoop.main)
            .sink { [weak self] text in
                guard let self, destinationAmountView.textField.isFirstResponder else { return }
                guard let text, !text.isEmpty else {
                    sourceAmountView.textField.text = ""
                    return
                }
                do {
                    destinationAmountView.update(error: nil)
                    let destinationAmount = try viewModel.input(destinationAmount: text)
                    sourceAmountView.textField.text = destinationAmount
                } catch {
                    destinationAmountView.update(error: error)
                }
            }
            .store(in: &cancellables)
        
        Publishers.Merge(sourceAmountPublisher, destinationAmountPublisher)
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                guard let self else { return }
                summaryButton.isEnabled = viewModel.isValid
            }
            .store(in: &cancellables)
    }
    
    func setupBinding() {
        sourceAmountView.bind(symbol: viewModel.sourceSymbol)
        destinationAmountView.bind(symbol: viewModel.destinationSymbol)
    }
}

#Preview {
    UINavigationController(rootViewController: CurrencyConversionController())
}
