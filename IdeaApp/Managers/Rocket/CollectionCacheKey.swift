import Foundation

/**
 All the collection cache keys should be unique.
 This enum helps keep this organized.
 */
enum CollectionCacheKey {
    case listCard(Int)
    case listVoucher(Int)
    
    func cacheKey() -> String {
        switch self {
        case .listCard(let listCard):
            return "listCard:\(listCard)"
        case .listVoucher(let listCard):
            return "listVoucher:\(listCard)"
        }
    }
}
