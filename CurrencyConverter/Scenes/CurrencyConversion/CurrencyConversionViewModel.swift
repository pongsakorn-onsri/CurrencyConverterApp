import Foundation

protocol CurrencyConversionViewModel {
    var sourceSymbol: String { get }
    var destinationSymbol: String { get }
    var rate: Double { get }
    var isValid: Bool { get }
    
    func input(sourceAmount: String) throws -> String
    func input(destinationAmount: String) throws -> String
    func getSummaryModel() -> SummaryViewModel?
}

enum CurrencyConversion: Error, LocalizedError {
    case invalidText
    case lessThanMinimum
    
    var errorDescription: String? {
        switch self {
        case .invalidText: "Invalid Input"
        case .lessThanMinimum: "Input amount less than \(CurrencyConversionViewModelImpl.Constant.minimumAmount)"
        }
    }
}

final class CurrencyConversionViewModelImpl: CurrencyConversionViewModel {
    var inputSource: String = ""
    var sourceCurrency: CurrencySymbol
    var inputDestination: String = ""
    var destinationCurrency: CurrencySymbol
    var rate: Double
    var converter: Convertable
    var isValid: Bool {
        getSummaryModel() != nil
    }
    
    init(
        sourceCurrency: CurrencySymbol = .USD,
        destinationCurrency: CurrencySymbol = .VND,
        rate: Double = 25379.57,
        converter: Convertable = ExchangeConverter()
    ) {
        self.sourceCurrency = sourceCurrency
        self.destinationCurrency = destinationCurrency
        self.rate = rate
        self.converter = converter
    }
    
    func input(sourceAmount: String) throws -> String {
        inputSource = sourceAmount
        guard let amount = Double(sourceAmount) else {
            throw CurrencyConversion.invalidText
        }
        guard amount >= Constant.minimumAmount else {
            throw CurrencyConversion.lessThanMinimum
        }
        let result = converter.convert(sourceAmount: amount, rate: rate)
        inputDestination = String(format: "%.2f", result)
        return inputDestination
    }
    
    func input(destinationAmount: String) throws -> String {
        inputDestination = destinationAmount
        guard let amount = Double(destinationAmount) else {
            throw CurrencyConversion.invalidText
        }
        guard amount >= Constant.minimumAmount else {
            throw CurrencyConversion.lessThanMinimum
        }
        let result = converter.convert(destinationAmount: amount, rate: rate)
        inputSource = String(format: "%.2f", result)
        return inputSource
    }
    
    func getSummaryModel() -> SummaryViewModel? {
        let source = Double(inputSource)
        let destination = Double(inputDestination)
        guard let source, let destination else { return nil }
        guard source >= Constant.minimumAmount && destination >= Constant.minimumAmount else { return nil }
        return SummaryViewModelImpl(
            source: InputCurrency(amount: source, currency: sourceCurrency),
            destination: InputCurrency(amount: destination, currency: destinationCurrency),
            rate: rate
        )
    }
}

extension CurrencyConversionViewModelImpl {
    var sourceSymbol: String { sourceCurrency.rawValue }
    var destinationSymbol: String { destinationCurrency.rawValue }
    
    enum Constant {
        static let minimumAmount: Double = 10
    }
}
