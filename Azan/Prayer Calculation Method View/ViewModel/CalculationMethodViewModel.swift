import Foundation

class CalculationMethodViewModel {
    var methods: [SolatCalculationMethod] {
        return SolatCalculationMethod.allCases
    }
}
