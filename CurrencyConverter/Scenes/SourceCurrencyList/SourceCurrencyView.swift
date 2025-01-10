import UIKit

protocol SourceCurrencyViewDelegate: AnyObject {
    func didSelectSource(currency: CurrencySymbol)
}

final class SourceCurrencyView: UIView {
    // MARK: UI Components
    private var flagLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 50, weight: .regular)
        return label
    }()
    private var symbolLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .bold)
        return label
    }()
    private var rateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    private var nextImageView: UIImageView = {
        let imageView = UIImageView(
            image: UIImage(systemName: "chevron.right")
        )
        imageView.tintColor = .black
        return imageView
    }()
    
    private lazy var symbolView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [symbolLabel, rateLabel])
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .lastBaseline
        return stackView
    }()
    
    private lazy var titleView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [symbolView, nameLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    private lazy var contentView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [flagLabel, titleView, UIView(), nextImageView])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: Model
    private(set) var currency: CurrencySymbol
    weak var delegate: SourceCurrencyViewDelegate?
    
    init(currency: CurrencySymbol) {
        self.currency = currency
        super.init(frame: .zero)
        isUserInteractionEnabled = true
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        delegate?.didSelectSource(currency: currency)
    }
    
    func bind(rate: Double) {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.usesSignificantDigits = true
        let formattedRate = formatter.string(from: NSNumber(floatLiteral: rate))
        rateLabel.text = "\(formattedRate ?? "")"
    }
}

private extension SourceCurrencyView {
    func setupViews() {
        bind(currency: currency)
        setupStyle()
        setupComponents()
        setupConstraints()
    }
    
    func bind(currency: CurrencySymbol) {
        flagLabel.text = currency.flag
        symbolLabel.text = currency.rawValue
        nameLabel.text = currency.name
    }
    
    func setupStyle() {
        layer.borderWidth = 1
        layer.cornerRadius = 16
    }
    
    func setupComponents() {
        addSubview(contentView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
