import Testing
import Foundation
@testable import CurrencyConverter

@Suite("HistoryListViewModel")
struct HistoryListViewModelTests {
    let viewModel: HistoryListViewModel
    let persistence: Persistence
    
    init() {
        self.persistence = LocalStorage(userDefaults: UserDefaultMock())
        self.viewModel = HistoryListViewModelImpl(persistence: persistence)
    }
    
    @Test("Started with no saved history")
    func whenInitialState() async throws {
        #expect(viewModel.items.isEmpty)
    }
    
    @Test("When save summary then should show in history")
    func whenHaveItemHistory() async throws {
        #expect(viewModel.items.isEmpty)
        
        persistence.saveValue(
            items: [
                HistoryItem(
                    source: .init(amount: 10, currency: .USD),
                    destination: .init(amount: 20, currency: .VND),
                    rate: 2
                )
            ],
            for: HistoryItem.key
        )
        
        _ = await viewModel.fetchHistory()
        #expect(viewModel.items.count == 1)
        #expect(viewModel.items.first?.source.amount == 10)
        #expect(viewModel.items.first?.source.currency == .USD)
        #expect(viewModel.items.first?.destination.amount == 20)
        #expect(viewModel.items.first?.destination.currency == .VND)
        #expect(viewModel.items.first?.rate == 2)
    }
}
