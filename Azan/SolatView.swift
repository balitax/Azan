import SwiftUI

struct SolatView: View {

    let title: String
    let time: String
    let icon: String

    init(title: String, time: String, icon: String = "") {
        self.title = title
        self.time = time
        self.icon = icon
    }

    var body: some View {
        HStack {
            if !icon.isEmpty {
                Image(systemName: icon)
            }
            Text(title.uppercased())
                .fontWeight(.semibold)
            Spacer()
            Text(time)
                .fontWeight(.semibold)
        }
        .padding()
    }
}

struct SolatView_Previews: PreviewProvider {
    static var previews: some View {
        SolatView(title: "Zuhur", time: "8:50 AM", icon: "icon.max.fill")
            .previewLayout(.sizeThatFits)
    }
}
