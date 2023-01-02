//
//  ContentView.swift
//  NoCameraSound_Opener
//
//  Created by straight-tamago on 2023/01/02.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @Environment(\.scenePhase) private var scenePhase
    private let player = AVPlayer(url: Bundle.main.url(forResource: "tutorial", withExtension: "mp4")!)
    var body: some View {
        VStack {
            if UserDefaults.standard.bool(forKey: "Firstboot") == false {
                Text("Firstboot - Setup")
                    .font(.title)
                Text("No Shortcut Banner!!!!")
                    .font(.title)
                VideoPlayer(player: player)
                    .frame(height: 600, alignment: .bottomTrailing)
                Button("I understand") {
                    UserDefaults.standard.set(true, forKey: "Firstboot")
                    
                    if let url = URL(string: "shortcuts://run-shortcut?name=NoCameraSound") {
                        UIApplication.shared.open(url)
                    }
                }
                .font(.title)
            }else {
                Text("Opening NoCameraSound Shortcut")
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .onChange(of: scenePhase) { phase in
                        if phase == .background {
                            print("バックグラウンド！")
                            
                        }
                        if phase == .active {
                            print("フォアグラウンド！")
                            if let url = URL(string: "shortcuts://run-shortcut?name=NoCameraSound") {
                                UIApplication.shared.open(url)
                            }
                        }
                        if phase == .inactive {
                            print("バックグラウンドorフォアグラウンド直前")
                        }
                    }
                Indicator().frame(width: 100, height: 100)
            }
        }
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
