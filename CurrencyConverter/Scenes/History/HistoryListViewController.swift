import UIKit

protocol HistoryListViewControllerDelegate: AnyObject {
    func didSelectHistory(item: HistoryItem)
}

final class HistoryListViewController: UIViewController {
    // MARK: UI Components
    private lazy var emptyTitle: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .extraLargeTitle)
        label.text = "No history found :("
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(HistoryListCell.self, forCellReuseIdentifier: HistoryListCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .red
        tableView.separatorInset = .zero
        return tableView
    }()
    
    // MARK: ViewModels
    private var viewModel: HistoryListViewModel
    weak var delegate: HistoryListViewControllerDelegate?
    
    init(viewModel: HistoryListViewModel = HistoryListViewModelImpl()) {
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
            _ = await viewModel.fetchHistory()
            refresh()
        }
    }
    
    func refresh() {
        tableView.reloadData()
        emptyTitle.isHidden = !viewModel.items.isEmpty
    }
}

private extension HistoryListViewController {
    func setupViews() {
        title = "History"
        view.backgroundColor = .white
        setupComponents()
        setupConstraints()
    }
    
    func setupComponents() {
        view.addSubview(tableView)
        view.addSubview(emptyTitle)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            emptyTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension HistoryListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        min(10, viewModel.items.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: HistoryListCell.identifier,
            for: indexPath
        ) as? HistoryListCell ?? HistoryListCell()
        cell.bind(item: viewModel.items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = viewModel.items[indexPath.row]
        delegate?.didSelectHistory(item: item)
    }
}

#Preview {
    HistoryListViewController()
}
