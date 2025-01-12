import Testing
@testable import CurrencyConverter

@Suite("Currency Conversion Prefilled", .tags(.criticalFunctionality))
struct CurrencyConversionViewModelPrefilledTests {
    let viewModel: CurrencyConversionViewModel
    
    init() {
        self.viewModel = CurrencyConversionViewModelImpl(
            source: .init(amount: 10, currency: .USD),
            destination: .init(amount: 20, currency: .VND),
            rate: 2,
            converter: ExchangeConverter()
        )
    }
    
    @Test("Started with prefilled input from history")
    func whenPrefilledModel() async throws {
        #expect(viewModel.inputSource == "10.0")
        #expect(viewModel.sourceSymbol == "USD")
        #expect(viewModel.inputDestination == "20.0")
        #expect(viewModel.destinationSymbol == "VND")
        #expect(viewModel.rate == 2)
        #expect(viewModel.isValid == true)
    }
}
