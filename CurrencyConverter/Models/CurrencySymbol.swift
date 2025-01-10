import Foundation

enum CurrencySymbol: String, CaseIterable {
    case USD
    case MYR
    case VND
    case MMK
    case IDR
}

extension CurrencySymbol {
    var name: String {
        switch self {
        case .USD: "United States Dollar"
        case .MYR: "Malaysian Ringgit"
        case .VND: "Vietnamese Dong"
        case .MMK: "Myanmar Kyat"
        case .IDR: "Indonesian Rupiah"
        }
    }
    
    var flag: String {
        switch self {
        case .USD: "🇺🇸"
        case .MYR: "🇲🇾"
        case .VND: "🇻🇳"
        case .MMK: "🇲🇲"
        case .IDR: "🇮🇩"
        }
    }
}
