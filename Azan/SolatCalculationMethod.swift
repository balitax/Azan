import Foundation
import Adhan

enum SolatCalculationMethod: Int, CaseIterable {
    case muslimWorldLeague = 0
    case egyptian
    case karachi
    case ummAlQura
    case dubai
    case moonsightingCommitee
    case northAmerica
    case kuwait
    case qatar
    case singapore
    case tehran
    case other

    var label: String {
        switch self {
        case .muslimWorldLeague:
            return "Muslim World League"
        case .egyptian:
            return "Egyptian"
        case .karachi:
            return "Karachi"
        case .ummAlQura:
            return "Umm-Al Qura"
        case .dubai:
            return "Dubai"
        case .moonsightingCommitee:
            return "Moonsighting Commitee"
        case .northAmerica:
            return "North America"
        case .kuwait:
            return "Kuwait"
        case .qatar:
            return "Qatar"
        case .singapore:
            return "Singapore"
        case .tehran:
            return "Tehran"
        case .other:
            return "Other"
        }
    }

    var adhanCalculationMethod: CalculationMethod {
        switch self {
        case .muslimWorldLeague:
            return .muslimWorldLeague
        case .egyptian:
            return .egyptian
        case .karachi:
            return .karachi
        case .ummAlQura:
            return .ummAlQura
        case .dubai:
            return .dubai
        case .moonsightingCommitee:
            return .moonsightingCommittee
        case .northAmerica:
            return .northAmerica
        case .kuwait:
            return .kuwait
        case .qatar:
            return .qatar
        case .singapore:
            return .singapore
        case .tehran:
            return .tehran
        case .other:
            return .other
        }
    }
}
