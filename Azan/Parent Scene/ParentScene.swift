
import SwiftUI

struct ParentScene: View {

    @ObservedObject private var viewModel: ParentViewModel
    @EnvironmentObject private var settings: Settings

    init(viewModel: ParentViewModel = ParentViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            if viewModel.isLocationEnabled {
                TodayScene(viewModel: TodayViewModel(calculationMethod: settings.calculationMethod, madhab: settings.madhab))
            } else {
                LocationPermissionScene()
            }
        }
        .onAppear(perform: viewModel.requestUserPermission)
    }
}

struct ParentScene_Previews: PreviewProvider {
    static var previews: some View {
        ParentScene()
    }
}
