import UIKit

final class InputAmountView: UIStackView {
    private(set) var textField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .decimalPad
        textField.textAlignment = .right
        textField.font = .preferredFont(forTextStyle: .largeTitle)
        textField.adjustsFontSizeToFitWidth = true
        textField.minimumFontSize = 0.5
        return textField
    }()
    private var symbolLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .extraLargeTitle)
        label.text = CurrencySymbol.USD.rawValue
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    private(set) var errorLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .systemRed
        label.textAlignment = .right
        label.isHidden = true
        return label
    }()
    
    private lazy var inputStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textField, errorLabel])
        stackView.axis = .vertical
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(symbol: String) {
        symbolLabel.text = symbol
    }
    
    func update(error: Error?) {
        errorLabel.isHidden = error == nil
        errorLabel.text = error?.localizedDescription
    }
}

private extension InputAmountView {
    func setupViews() {
        setupStyle()
        setupComponents()
    }
    
    func setupStyle() {
        axis = .horizontal
        alignment = .center
        spacing = 16
        layoutMargins = .init(top: 16, left: 16, bottom: 16, right: 16)
        layer.borderWidth = 1
        layer.cornerRadius = 16
        isLayoutMarginsRelativeArrangement = true
    }
    
    func setupComponents() {
        addArrangedSubview(inputStackView)
        addArrangedSubview(symbolLabel)
    }
}
