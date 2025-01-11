import UIKit

final class SummaryViewController: UIViewController {
    // MARK: UI Components
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .extraLargeTitle)
        label.text = "Currency Converter"
        return label
    }()
    private lazy var sourceAmountView = InputAmountView()
    private lazy var destinationAmountView = InputAmountView()
    private var rateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    private var arrowDownImageView: UIImageView = {
        let image = UIImage(systemName: "arrowshape.down.fill")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        return imageView
    }()
    
    private lazy var contentView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, sourceAmountView, arrowDownImageView, destinationAmountView, rateLabel])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.layoutMargins = .init(top: 16, left: 16, bottom: 16, right: 16)
        stackView.layer.borderWidth = 1
        stackView.layer.cornerRadius = 16
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var shareButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.configuration?.title = "Save & Share"
        button.configuration?.image = UIImage(systemName: "square.and.arrow.up")
        button.configuration?.buttonSize = .large
        return button
    }()
    
    private var homeButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.configuration?.title = "Home"
        button.configuration?.image = UIImage(systemName: "house")
        button.configuration?.buttonSize = .large
        return button
    }()
    
    private lazy var centerView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [contentView, shareButton, homeButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: ViewModels
    private var viewModel: SummaryViewModel
    
    init(viewModel: SummaryViewModel = SummaryViewModelImpl()) {
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

private extension SummaryViewController {
    func setupViews() {
        setupStyle()
        setupComponents()
        setupConstraints()
        setupActions()
        setupBinding()
    }
    
    func setupStyle() {
        view.backgroundColor = .white
    }
    
    func setupComponents() {
        view.addSubview(centerView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            centerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            centerView.layoutMarginsGuide.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            centerView.layoutMarginsGuide.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    func setupActions() {
        shareButton.addAction(shareAction(), for: .touchUpInside)
        homeButton.addAction(homeAction(), for: .touchUpInside)
    }
    
    func setupBinding() {
        let rateText = "Currency Rate 1 \(viewModel.source.currency.rawValue) = \(viewModel.rate.formatted()) \(viewModel.destination.currency.rawValue)"
        rateLabel.text = rateText
        sourceAmountView.textField.isEnabled = false
        sourceAmountView.textField.text = "\(viewModel.source.amount)"
        sourceAmountView.bind(symbol: viewModel.source.currency.rawValue)
        destinationAmountView.textField.isEnabled = false
        destinationAmountView.textField.text = "\(viewModel.destination.amount)"
        destinationAmountView.bind(symbol: viewModel.destination.currency.rawValue)
    }
    
    func shareAction() -> UIAction {
        UIAction { [weak self] _ in
            guard let self else { return }
            let activityController = UIActivityViewController(activityItems: [contentView.asImage()], applicationActivities: nil)
            self.showDetailViewController(activityController, sender: nil)
        }
    }
    
    func homeAction() -> UIAction {
        UIAction { [weak self] _ in
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }
}

extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

#Preview {
    UINavigationController(rootViewController: SummaryViewController())
}
