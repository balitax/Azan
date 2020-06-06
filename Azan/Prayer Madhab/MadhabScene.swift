import SwiftUI

struct MadhabScene: View {

    @EnvironmentObject var setting: Settings

    private let viewModel: MadhabViewModel

    init(viewModel: MadhabViewModel = MadhabViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        List {
            ForEach(viewModel.madhabs, id: \.self) { madhab in
                Button(action: {
                    self.setting.madhab = madhab
                }) {
                    Text(madhab.label)
                        .padding()
                }
            }
        }
        .navigationBarTitle("Madhab", displayMode: .inline)
    }
}

struct MadhabScene_Previews: PreviewProvider {
    static var previews: some View {
        MadhabScene(viewModel: MadhabViewModel())
    }
}
