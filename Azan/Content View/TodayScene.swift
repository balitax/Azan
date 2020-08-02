import SwiftUI

struct TodayScene: View {

    @ObservedObject private var viewModel: TodayViewModel
    @EnvironmentObject private var settings: Settings

    @State var nextPrayer: String = ""
    @State var currentTime: String = ""
    @State var isSettingsPresented = false

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    init(viewModel: TodayViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            List {
                Section(header:
                    VStack(alignment: .leading) {
                        Text(viewModel.currentHijriDate)
                            .fontWeight(.medium)
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding(.vertical, 20)
                        Text("Next Prayer")
                            .fontWeight(.bold)
                            .font(.system(size: 21))
                            .foregroundColor(.primary)
                            .padding(.bottom, 5)
                    }
                    .padding(.leading, -15)
                    ) {
                    VStack(alignment: .leading, spacing: 15) {
                        Text(nextPrayer)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .onReceive(timer) { output in
                                self.nextPrayer = "\(self.viewModel.relativeTimeNextPrayer) left until \(self.viewModel.nextPrayer)"
                        }
                        Text(currentTime)
                            .font(Font.headline.monospacedDigit())
                            .fontWeight(.medium)
                            .foregroundColor(.secondary)
                            .onReceive(timer) { output in
                                self.currentTime = self.viewModel.currentTime
                        }
                        HStack{
                            Image(systemName: "mappin.circle.fill")
                            Text(viewModel.locality)
                                .fontWeight(.medium)
                        }
                        .font(.headline)
                    }
                .padding()
                }
                Section(header:
                    Text("Prayer Times")
                        .fontWeight(.bold)
                        .font(.system(size: 21))
                        .foregroundColor(.primary)
                        .padding(.leading, -15)
                        .padding(.bottom, 5)
                    , footer:
                    Text("\(settings.calculationMethod.label)")
                        .font(.footnote)
                ) {
                    SolatView(title: "Subuh", time: viewModel.fajr, icon: "sunrise.fill")
                    SolatView(title: "Zuhur", time: viewModel.dhuhr, icon: "sun.max.fill")
                    SolatView(title: "Asar", time: viewModel.asr, icon: "sun.min.fill")
                    SolatView(title: "Maghrib", time: viewModel.maghrib, icon: "sunset.fill")
                    SolatView(title: "Isyak", time: viewModel.isha, icon: "moon.stars.fill")
                }
            }.listStyle(GroupedListStyle()).environment(\.horizontalSizeClass, .regular)
            .onReceive(settings.objectWillChange, perform: { _ in
                self.viewModel.refreshPrayerTimes()
            })
            .navigationBarTitle("Today")
                .navigationBarItems(trailing:
                    Button(action: {
                        self.isSettingsPresented = true
                    }, label: {
                        Image(systemName: "slider.horizontal.3")
                            .imageScale(.large)
                            .padding()
                            .accentColor(.primary)
                    })
                    .sheet(isPresented: $isSettingsPresented) {
                        SettingsView(isPresented: self.$isSettingsPresented)
                            .environmentObject(self.settings)
                    }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TodayScene(viewModel: TodayViewModel(calculationMethod: .muslimWorldLeague, madhab: .shafi))
    }
}
