import Foundation

/// Determine how Asar is calculated
enum AsarCalculationMethod: Int, CaseIterable {
    /// Applicable for Maliki, Hanbali, Jafari
    case shafi = 1

    case hanafi = 2

    var title: String {
        switch self {
        case .shafi:
            return "shafi"
        case .hanafi:
            return "hanafi"
        }
    }
}
