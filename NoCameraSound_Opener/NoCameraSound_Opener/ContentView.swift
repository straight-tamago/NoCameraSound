//
//  ContentView.swift
//  NoCameraSound_Opener
//
//  Created by mini on 2023/01/02.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Opening NoSoundCamera\n&\n[OpenCamera] Shortcut")
            .multilineTextAlignment(.center)
            .font(.title)
            .onAppear {
                if let url = URL(string: "NoCameraSound://OpenCamera") {
                    UIApplication.shared.open(url)
                }
            }
        Indicator().frame(width: 100, height: 100)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Indicator: UIViewRepresentable {
    typealias UIViewType = UIActivityIndicatorView

    @State var isAnimating: Bool = true
    let style: UIActivityIndicatorView.Style = .medium

    func makeUIView(context: UIViewRepresentableContext<Indicator>) -> Indicator.UIViewType {
        UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Indicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
