import Testing
@testable import CurrencyConverter


@Suite("DestinationCurrencyList")
struct DestinationCurrencyListViewModelTests {
    let viewModel: DestinationCurrencyListViewModelImpl
    var networkService = NetworkServiceMock()
    
    init() {
        self.viewModel = DestinationCurrencyListViewModelImpl(
            sourceCurrency: .VND,
            networkService: networkService
        )
    }
    
    @Test
    func whenFetchCurrencyRateButInvalidURL() async throws {
        networkService.apiError = .invalidURL
        await #expect(throws: APIError.invalidURL, performing: {
            try await viewModel.fetchCurrencyRates()
        })
    }
    
    @Test
    func whenFetchCurrencyRateButNotFoundResponse() async throws {
        networkService.apiError = .notFound
        await #expect(throws: APIError.notFound, performing: {
            try await viewModel.fetchCurrencyRates()
        })
    }
    
    @Test
    func whenFetchCurrencyRateButDecodeResponseFailed() async throws {
        networkService.apiError = .decodeResponseFailed
        await #expect(throws: APIError.decodeResponseFailed, performing: {
            try await viewModel.fetchCurrencyRates()
        })
    }
    
    @Test
    func whenFetchCurrencyRateSuccess() async throws {
        #expect(viewModel.getRate(currency: .USD) == nil)
        try await viewModel.fetchCurrencyRates()
        
        #expect(viewModel.getRate(currency: .USD) == 1.0)
        
        #expect(viewModel.items.first?.symbol == .USD)
        #expect(viewModel.items.last?.symbol == .IDR)
    }
}
