import SwiftUI
import Lottie
import Foundation

struct AnimationView: UIViewRepresentable {
    let filename: String
    let animationView = Lottie.AnimationView()

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        animationView.animation = Animation.named(filename)
        animationView.contentMode = .scaleAspectFit
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        animationView.play()
    }
}

struct AnimationView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationView(filename: "")
    }
}
