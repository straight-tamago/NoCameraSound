//
//  NoCameraSound_OpenerApp.swift
//  NoCameraSound_Opener
//
//  Created by mini on 2023/01/02.
//

import SwiftUI

@main
struct NoCameraSound_OpenerApp: App {
    @Environment(\.scenePhase) private var scenePhase
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase) { phase in
            if phase == .background {
                print("バックグラウンド！")
                
            }
            if phase == .active {
                print("フォアグラウンド！")
                if let url = URL(string: "NoCameraSound://OpenCamera") {
                    UIApplication.shared.open(url)
                }
            }
            if phase == .inactive {
                print("バックグラウンドorフォアグラウンド直前")
            }
        }
    }
}
