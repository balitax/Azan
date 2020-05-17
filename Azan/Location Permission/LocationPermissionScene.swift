import SwiftUI

struct LocationPermissionScene: View {
    var body: some View {
        VStack {
            Text("Turn on your location")
                .font(.largeTitle)
                .fontWeight(.black)
                .padding(.horizontal, 40)
                .multilineTextAlignment(.center)
            Text("Azan require location access to work properly. Please enable location access so that accurate results of current prayer times can be shown.")
                .font(.body)
                .padding(.horizontal, 30)
                .padding(.vertical, 20)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            Button(action: {
                print("button settings tapped")
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            }, label: {
                Text("Enable location in Settings")
                    .fontWeight(.bold)
                    .font(.body)
                    .foregroundColor(Color.accentColor)
                .padding(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.accentColor, lineWidth: 3)
                )
            })
        }
    }
}

struct LocationPermissionScene_Previews: PreviewProvider {
    static var previews: some View {
        LocationPermissionScene()
    }
}
