import UIKit

final class SummaryView: UIStackView {
    private(set) var titleLabel: UILabel = {
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
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(source: InputCurrency, destination: InputCurrency, rate: Double) {
        sourceAmountView.textField.isEnabled = false
        sourceAmountView.textField.text = "\(source.amount)"
        sourceAmountView.bind(symbol: source.currency.rawValue)
        destinationAmountView.textField.isEnabled = false
        destinationAmountView.textField.text = "\(destination.amount)"
        destinationAmountView.bind(symbol: destination.currency.rawValue)
        let rateText = "Currency Rate 1 \(source.currency.rawValue) = \(rate.formatted()) \(destination.currency.rawValue)"
        rateLabel.text = rateText
    }
}

private extension SummaryView {
    func setupViews() {
        setupStyle()
        setupComponents()
    }
    
    func setupStyle() {
        axis = .vertical
        spacing = 16
        alignment = .center
        layoutMargins = .init(top: 16, left: 16, bottom: 16, right: 16)
        layer.borderWidth = 1
        layer.cornerRadius = 16
        isLayoutMarginsRelativeArrangement = true
    }
    
    func setupComponents() {
        [titleLabel, sourceAmountView, arrowDownImageView, destinationAmountView, rateLabel]
            .forEach(addArrangedSubview)
    }
}
