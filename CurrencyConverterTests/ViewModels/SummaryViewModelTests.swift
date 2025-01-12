import Testing
import Foundation
@testable import CurrencyConverter

@Suite("SummaryViewModel")
struct SummaryViewModelTests {
    let viewModel: SummaryViewModel
    let persistence: Persistence
    
    init() {
        self.persistence = LocalStorage(userDefaults: UserDefaultMock())
        self.viewModel = SummaryViewModelImpl(
            source: .init(amount: 10, currency: .USD),
            destination: .init(amount: 20, currency: .VND),
            rate: 2,
            persistence: persistence
        )
    }
    
    @Test("Started with initial state from source, destination and rate")
    func whenInitialState() async throws {
        #expect(viewModel.source.amount == 10)
        #expect(viewModel.source.currency == .USD)
        #expect(viewModel.destination.amount == 20)
        #expect(viewModel.destination.currency == .VND)
        #expect(viewModel.rate == 2)
    }
    
    @Test("When save summary to history", .disabled())
    func whenSaveCalled() async throws {
        viewModel.save()
        let items: [HistoryItem] = persistence.getValueList(for: HistoryItem.key)
        #expect(items.count == 1)
    }
}
