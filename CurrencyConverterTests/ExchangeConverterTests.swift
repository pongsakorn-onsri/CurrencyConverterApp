import Testing
@testable import CurrencyConverter

struct ExchangeConverterTests {

    @Test
    func convertSourceAmountToDestinationAmount() async throws {
        // MARK: Normal Cases
        var destinationAmount = ExchangeConverter().convert(sourceAmount: 1, rate: 5)
        #expect(destinationAmount == 5)
        
        destinationAmount = ExchangeConverter().convert(sourceAmount: 10, rate: 5)
        #expect(destinationAmount == 50)
        
        destinationAmount = ExchangeConverter().convert(sourceAmount: 100, rate: 0.971)
        #expect(destinationAmount == 97.1)
        
        // MARK: Lower Cases
        destinationAmount = ExchangeConverter().convert(sourceAmount: 0, rate: 0.971)
        #expect(destinationAmount == 0)
        
        destinationAmount = ExchangeConverter().convert(sourceAmount: 0, rate: 1.5)
        #expect(destinationAmount == 0)
        
        destinationAmount = ExchangeConverter().convert(sourceAmount: 0, rate: 3)
        #expect(destinationAmount == 0)
        
        destinationAmount = ExchangeConverter().convert(sourceAmount: 0.000001, rate: 1.5)
        #expect(destinationAmount == 0.0000015)
        
        destinationAmount = ExchangeConverter().convert(sourceAmount: 0.000001, rate: 3)
        #expect(destinationAmount == 0.000003)
        
        destinationAmount = ExchangeConverter().convert(sourceAmount: 0.000005, rate: 0.00019)
        #expect(destinationAmount == 0.00000000095)
        
        // MARK: Upper Cases
        destinationAmount = ExchangeConverter().convert(sourceAmount: 1000, rate: 1)
        #expect(destinationAmount == 1000)
        
        destinationAmount = ExchangeConverter().convert(sourceAmount: 1000000, rate: 1)
        #expect(destinationAmount == 1000000)
        
        destinationAmount = ExchangeConverter().convert(sourceAmount: 1000000, rate: 555)
        #expect(destinationAmount == 555000000)
        
        destinationAmount = ExchangeConverter().convert(sourceAmount: 1000000, rate: 555555)
        #expect(destinationAmount == 555555000000)
    }
    
    @Test
    func convertDestinationAmountToSourceAmount() async throws {
        // MARK: Normal Cases
        var sourceAmount = ExchangeConverter().convert(destinationAmount: 1, rate: 0.1)
        #expect(sourceAmount == 10)
        
        sourceAmount = ExchangeConverter().convert(destinationAmount: 1, rate: 5)
        #expect(sourceAmount == 0.2)
        
        sourceAmount = ExchangeConverter().convert(destinationAmount: 250, rate: 5)
        #expect(sourceAmount == 50)
        
        sourceAmount = ExchangeConverter().convert(destinationAmount: 100, rate: 0.971)
        #expect(sourceAmount == 102.98661174047375)
        
        // MARK: Lower Cases
        sourceAmount = ExchangeConverter().convert(destinationAmount: 0, rate: 0.971)
        #expect(sourceAmount == 0)
        
        sourceAmount = ExchangeConverter().convert(destinationAmount: 0, rate: 1.5)
        #expect(sourceAmount == 0)
        
        sourceAmount = ExchangeConverter().convert(destinationAmount: 0, rate: 3)
        #expect(sourceAmount == 0)
        
        sourceAmount = ExchangeConverter().convert(destinationAmount: 0.0002, rate: 1.5)
        #expect(sourceAmount == 0.00013333333333333334)
        
        sourceAmount = ExchangeConverter().convert(destinationAmount: 0.0002, rate: 0.05)
        #expect(sourceAmount == 0.004)
        
        sourceAmount = ExchangeConverter().convert(destinationAmount: 0.000005, rate: 0.00019)
        #expect(sourceAmount == 0.02631578947368421)
        
        // MARK: Upper Cases
        sourceAmount = ExchangeConverter().convert(destinationAmount: 1000, rate: 1)
        #expect(sourceAmount == 1000)
        
        sourceAmount = ExchangeConverter().convert(destinationAmount: 1000000, rate: 1)
        #expect(sourceAmount == 1000000)
        
        sourceAmount = ExchangeConverter().convert(destinationAmount: 1000000, rate: 555)
        #expect(sourceAmount == 1801.8018018018017)
        
        sourceAmount = ExchangeConverter().convert(destinationAmount: 1000000, rate: 555555)
        #expect(sourceAmount == 1.8000018000018)
    }
}
