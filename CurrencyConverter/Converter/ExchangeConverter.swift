import Foundation

public class ExchangeConverter: Convertable {
    public init() {}
    
    /// Function for convert source amount to to destination amount
    /// - Parameters:
    ///   - sourceAmount: Source Amount
    ///   - rate: Source Rate
    /// - Returns: Destination Amount
    public func convert(sourceAmount: Double, rate: Double) -> Double {
        sourceAmount * rate
    }
    
    /// Function for convert destination amount to source amount
    /// - Parameters:
    ///   - destinationAmount: Destination Amount
    ///   - rate: Source Rate
    /// - Returns: Source Amount
    public func convert(destinationAmount: Double, rate: Double) -> Double {
        destinationAmount * (1 / rate)
    }
}
