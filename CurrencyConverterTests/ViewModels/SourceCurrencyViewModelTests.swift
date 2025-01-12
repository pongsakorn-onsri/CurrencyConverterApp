import Testing
@testable import CurrencyConverter


@Suite("SourceCurrencyView")
struct SourceCurrencyViewModelTests {
    let viewModel: SourceCurrencyListViewModel
    
    init() {
        self.viewModel = SourceCurrencyListViewModelImpl()
    }
    
    @Test
    func getSourceCurrencyItemList() async throws {
        #expect(viewModel.items.first == .USD)
        #expect(viewModel.items.last == .IDR)
    }
}
