
import SwiftUI

struct ParentScene: View {

    @ObservedObject private var viewModel: ParentViewModel

    init(viewModel: ParentViewModel = ParentViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            if viewModel.isLocationEnabled {
                ContentView()
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
