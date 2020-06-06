import Foundation
import Adhan

enum SolatMadhab: Int, CaseIterable {
    case shafi = 0
    case hanafi

    var label: String {
        switch self {
        case .shafi:
            return "shafi".capitalized
        case .hanafi:
            return "hanafi".capitalized
        }
    }

    var adhanMadhab: Madhab {
        switch self {
        case .shafi:
            return .shafi
        case .hanafi:
            return .hanafi
        }
    }
}
