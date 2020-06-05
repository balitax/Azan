import SwiftUI

struct CalculationMethodView: View {

    @EnvironmentObject var setting: Settings

    private let viewModel: CalculationMethodViewModel

    init(viewModel: CalculationMethodViewModel = CalculationMethodViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        List {
            ForEach(viewModel.methods, id: \.self) { method in
                Button(action: {
                    self.setting.calculationMethod = method
                }) {
                    Text(method.label)
                        .padding()
                }
            }
        }
    .navigationBarTitle("Prayer Calculation Method")
    }
}

struct PrayerCalculationMethodView_Previews: PreviewProvider {
    static var previews: some View {
        CalculationMethodView()
    }
}
