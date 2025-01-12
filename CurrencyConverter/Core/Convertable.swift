import Foundation

protocol Convertable {
    func convert(sourceAmount: Double, rate: Double) -> Double
    func convert(destinationAmount: Double, rate: Double) -> Double
}
