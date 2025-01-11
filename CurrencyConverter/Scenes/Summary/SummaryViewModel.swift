import Foundation

protocol SummaryViewModel {
    var source: InputCurrency { get }
    var destination: InputCurrency { get }
    var rate: Double { get }
    func save()
}

final class SummaryViewModelImpl: SummaryViewModel {
    let source: InputCurrency
    let destination: InputCurrency
    let rate: Double
    let persistence: Persistence
    
    init(
        source: InputCurrency = .init(amount: 100, currency: .USD),
        destination: InputCurrency = .init(amount: 2536673333333, currency: .VND),
        rate: Double = 25366.73,
        persistence: Persistence = LocalStorage()
    ) {
        self.source = source
        self.destination = destination
        self.rate = rate
        self.persistence = persistence
    }
    
    func save() {
        persistence.save(item: .init(source: source, destination: destination, rate: rate))
    }
}
