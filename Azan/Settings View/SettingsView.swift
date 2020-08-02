import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var settings: Settings

    @Binding var isPresented: Bool

    var body: some View {
        NavigationView {
            List {
                Section(header: HeaderView("General")) {
                    NavigationLink(destination: CalculationMethodView()) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Prayer Calculation Method")
                                .fontWeight(.semibold)
                            Text(settings.calculationMethod.label)
                                .fontWeight(.medium)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical)
                    }
                    NavigationLink(destination: MadhabScene()) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Madhab")
                                .fontWeight(.semibold)
                            Text(settings.madhab.label)
                                .fontWeight(.medium)
                                .foregroundColor(.secondary)
                        }
                    }
                    NavigationLink(destination: EmptyView()) {
                        Text("Location")
                        .fontWeight(.medium)
                        .padding()
                    }
                }
                Section(header: HeaderView("Contact")) {
                    Text("Email me at mfmokhtar@gmail.com")
                        .fontWeight(.medium)
                        .padding()
                    Text("Tweet to me at @faizmokh")
                        .fontWeight(.medium)
                        .padding()
                }
                Section(header: HeaderView("About"),
                        footer: Text("V0.1")) {
                    Text("About the app")
                        .fontWeight(.medium)
                        .padding()
                    Text("Acknowledgements")
                        .fontWeight(.medium)
                        .padding()
                }
            }
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .navigationBarItems(leading: Button(action: {
                self.isPresented = false
            }, label: {
                Image(systemName: "xmark")
                    .imageScale(.large)
                    .padding()
                    .accentColor(.primary)
            }))
            .navigationBarTitle("Settings", displayMode: .inline)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isPresented: .constant(true))
    }
}
