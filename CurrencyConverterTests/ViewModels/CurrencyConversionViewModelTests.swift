import Testing
@testable import CurrencyConverter

extension Tag {
    @Tag static var criticalFunctionality: Self
}

@Suite("Currency Conversion Selected", .tags(.criticalFunctionality))
struct CurrencyConversionViewModelTests {
    let viewModel: CurrencyConversionViewModel
    
    init() {
        self.viewModel = CurrencyConversionViewModelImpl(
            sourceCurrency: .USD,
            destinationCurrency: .VND,
            rate: 5,
            converter: ExchangeConverter()
        )
    }
    
    @Test("Started with selected source, destination and rate")
    func whenInitialModel() async throws {
        #expect(viewModel.inputSource == "")
        #expect(viewModel.sourceSymbol == "USD")
        #expect(viewModel.inputDestination == "")
        #expect(viewModel.destinationSymbol == "VND")
        #expect(viewModel.rate == 5)
        #expect(viewModel.isValid == false)
    }
    
    @Test("When input source amount less than minimum")
    func whenInputSourceLessthan10() async throws {
        #expect(throws: CurrencyConversionError.lessThanMinimum, performing: { try viewModel.input(sourceAmount: "5") })
        #expect(throws: CurrencyConversionError.lessThanMinimum, performing: { try viewModel.input(sourceAmount: "9") })
        #expect(throws: CurrencyConversionError.lessThanMinimum, performing: { try viewModel.input(sourceAmount: "9.9999") })
        #expect(throws: CurrencyConversionError.lessThanMinimum, performing: { try viewModel.input(sourceAmount: "0.00009") })
        #expect(throws: CurrencyConversionError.lessThanMinimum, performing: { try viewModel.input(sourceAmount: "0000000") })
        #expect(!viewModel.isValid)
    }
    
    @Test("When input source amount with other value than digits")
    func whenInputSourceInvalidText() async throws {
        #expect(throws: CurrencyConversionError.invalidText, performing: { try viewModel.input(sourceAmount: "Test") })
        #expect(throws: CurrencyConversionError.invalidText, performing: { try viewModel.input(sourceAmount: "...") })
        #expect(throws: CurrencyConversionError.invalidText, performing: { try viewModel.input(sourceAmount: "123ABCD") })
        #expect(throws: CurrencyConversionError.invalidText, performing: { try viewModel.input(sourceAmount: "ก") })
        #expect(!viewModel.isValid)
    }
    
    @Test("When input source amount correctly")
    func whenInputSourceAmountCorrectly() async throws {
        var destinationAmount: String?
        destinationAmount = try? viewModel.input(sourceAmount: "10")
        #expect(destinationAmount == "50.00")
        #expect(viewModel.isValid)
        
        destinationAmount = try? viewModel.input(sourceAmount: "100")
        #expect(destinationAmount == "500.00")
        #expect(viewModel.isValid)
        
        destinationAmount = try? viewModel.input(sourceAmount: "20")
        #expect(destinationAmount == "100.00")
        #expect(viewModel.isValid)
        
        destinationAmount = try? viewModel.input(sourceAmount: "900")
        #expect(destinationAmount == "4500.00")
        #expect(viewModel.isValid)
    }
    
    @Test("When input destination amount less than minimum")
    func whenInputDestinationLessthan10() async throws {
        #expect(throws: CurrencyConversionError.lessThanMinimum, performing: { try viewModel.input(destinationAmount: "5") })
        #expect(throws: CurrencyConversionError.lessThanMinimum, performing: { try viewModel.input(destinationAmount: "9") })
        #expect(throws: CurrencyConversionError.lessThanMinimum, performing: { try viewModel.input(destinationAmount: "9.9999") })
        #expect(throws: CurrencyConversionError.lessThanMinimum, performing: { try viewModel.input(destinationAmount: "0.00009") })
        #expect(throws: CurrencyConversionError.lessThanMinimum, performing: { try viewModel.input(destinationAmount: "0000000") })
        #expect(!viewModel.isValid)
    }
    
    @Test("When input destination amount other value than digits")
    func whenInputDestinationInvalidText() async throws {
        #expect(throws: CurrencyConversionError.invalidText, performing: { try viewModel.input(destinationAmount: "Test") })
        #expect(throws: CurrencyConversionError.invalidText, performing: { try viewModel.input(destinationAmount: "...") })
        #expect(throws: CurrencyConversionError.invalidText, performing: { try viewModel.input(destinationAmount: "123ABCD") })
        #expect(throws: CurrencyConversionError.invalidText, performing: { try viewModel.input(destinationAmount: "ก") })
        #expect(!viewModel.isValid)
    }
    
    @Test("When input destination amount correctly")
    func whenInputDestinationAmountCorrectly() async throws {
        var sourceAmount: String?
        sourceAmount = try? viewModel.input(destinationAmount: "10")
        #expect(sourceAmount == "2.00")
        #expect(!viewModel.isValid)
        
        sourceAmount = try? viewModel.input(destinationAmount: "100")
        #expect(sourceAmount == "20.00")
        #expect(viewModel.isValid)
        
        sourceAmount = try? viewModel.input(destinationAmount: "20")
        #expect(sourceAmount == "4.00")
        #expect(!viewModel.isValid)
        
        sourceAmount = try? viewModel.input(destinationAmount: "900")
        #expect(sourceAmount == "180.00")
        #expect(viewModel.isValid)
    }
}
