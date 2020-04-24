import SwiftUI

struct SettingsView: View {
    var body: some View {
        List {
            Section(header: Text("General")) {
                Text("Prayer Calculation Method")
                Text("Language")
                Text("Location")
            }
            Section(header: Text("Contact")) {
                Text("Email me at mfmokhtar@gmail.com")
                Text("Tweet to me at @faizmokh")
            }
            Section(header: Text("About"),
                    footer: Text("V0.1")) {
                Text("About the app")
                Text("Acknowledgements")
            }
        }
        .listStyle(GroupedListStyle())
        .environment(\.horizontalSizeClass, .regular)
        .navigationBarTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
