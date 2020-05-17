import SwiftUI

struct HeaderView: View {
    let title: String

    init(_ title: String) {
        self.title = title
    }

    var body: some View {
        Text(title)
            .fontWeight(.bold)
            .font(.headline)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView("General")
        .previewLayout(.sizeThatFits)
    }
}
