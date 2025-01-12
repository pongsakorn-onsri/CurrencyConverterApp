import UIKit

final class HistoryListCell: UITableViewCell {
    static let identifier = "HistoryListCell"
    
    private lazy var summaryView: SummaryView = {
        let view = SummaryView()
        view.titleLabel.isHidden = true
        view.layer.cornerRadius = 0
        view.layer.borderWidth = 0
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(item: HistoryItem) {
        summaryView.bind(source: item.source, destination: item.destination, rate: item.rate)
    }
}

private extension HistoryListCell {
    func setupViews() {
        setupComponents()
        setupConstraints()
    }
    
    func setupComponents() {
        contentView.addSubview(summaryView)
    }
    
    func setupConstraints() {
        summaryView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            summaryView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            summaryView.topAnchor.constraint(equalTo: contentView.topAnchor),
            summaryView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            summaryView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
