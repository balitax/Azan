import Foundation
import Combine

class Settings: ObservableObject {
    @Published var calculationMethod: SolatCalculationMethod = .muslimWorldLeague
}
