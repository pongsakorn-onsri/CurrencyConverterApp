import UIKit

final class ErrorSheetViewController: UIViewController {
    // MARK: UI Components
    private var closeButton: UIButton = {
        let button = UIButton(configuration: .plain())
        button.configuration?.image = UIImage(systemName: "xmark")?
            .withTintColor(.black, renderingMode: .alwaysOriginal)
            .applyingSymbolConfiguration(.init(pointSize: 30))
        button.configuration?.buttonSize = .large
        button.configuration?.baseBackgroundColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .extraLargeTitle2)
        label.text = error.localizedDescription
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [UIView(), closeButton])
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .trailing
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 0, left: 16, bottom: 16, right: -16)
        return stackView
    }()
    private lazy var contentView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topStackView, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.backgroundColor = .white
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 16, left: 16, bottom: 16, right: 16)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: Model
    let error: Error
    
    init(error: Error) {
        self.error = error
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if touches.first?.view == view {
            dismiss(animated: false)
        }
    }
}

private extension ErrorSheetViewController {
    func setupViews() {
        view.backgroundColor = .black.withAlphaComponent(0.2)
        setupComponents()
        setupConstraints()
        setupActions()
    }
    
    func setupComponents() {
        view.addSubview(contentView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupActions() {
        closeButton.addAction(closeAction(), for: .touchUpInside)
    }
    
    func closeAction() -> UIAction {
        UIAction { [weak self] _ in
            self?.dismiss(animated: false)
        }
    }
}

#Preview {
    ErrorSheetViewController(error: APIError.decodeResponseFailed)
}
