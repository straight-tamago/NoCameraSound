//
//  ContentView.swift
//  NoCameraSound
//
//  Created by straight-tamago★ on 2022/12/28.
//

import SwiftUI
import AudioToolbox

struct ContentView: View {
    @Environment(\.scenePhase) private var scenePhase
    private let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    @State var logMessage = ""
    @State private var viewLog = true
    @State private var settingsShowing = false
    @State private var restoreConfirm = false
    @State private var updateAlert = false
    @State private var updateAvailable = false
    @State private var notCompatibleWithIOS14 = false
    @State var isShutterSoundDisabled = false
    @State var targetFilePathItems: [TargetFilePathItem] = defaultTargetFilePathItems
    
    var body: some View {
        let areAllSoundsActuallyDisabled = targetFilePathItems.allSatisfy { isSucceeded(targetFilePath: "file://"+$0.path) }

        VStack {
            if viewLog {
                Text("")
                    .frame(width: 300, height: 200)
                    .disabled(true)
            }
            Text("NoCameraSound").font(.largeTitle).fontWeight(.bold)
            HStack {
                Button(action: {
                    if areAllSoundsActuallyDisabled {
                        restoreConfirm = true
                    } else {
                        disableShutterSound()
                        isShutterSoundDisabled = true
                    }
                }) {
                    Text(areAllSoundsActuallyDisabled ? "Restore Shutter Sound" : "Disable Shutter Sound")
                }
                .padding()
                .accentColor(Color.white)
                .background(Color.blue)
                .cornerRadius(26)
                .shadow(color: Color.purple, radius: 15, x: 0, y: 5)
                .alert(isPresented: $restoreConfirm) {
                    Alert(title: Text("Restore Shutter Sound?"),
                          primaryButton: .destructive(Text("Restore"), action: restoreShutterSoundSP),
                          secondaryButton: .default(Text("Cancel"))
                    )
                }

                Button {
                    settingsShowing = true
                } label: {
                    Image(systemName: "info.circle")
                        .padding()
                        .accentColor(Color.white)
                        .background(Color.blue)
                        .cornerRadius(26)
                        .shadow(color: Color.purple, radius: 15, x: 0, y: 5)
                }.actionSheet(isPresented: $settingsShowing) {
                    ActionSheet(title: Text("NoCameraSound v\(version)"), message: Text("by straight-tamago"), buttons: [
                        .default(Text("Source Code")) {
                            if let url = URL(string: "https://github.com/straight-tamago/NoCameraSound") {
                                UIApplication.shared.open(url)
                            }
                        },
                        .default(Text("MacDirtyCowDemo (Exploit)")) {
                            if let url = URL(string: "https://github.com/zhuowei/MacDirtyCowDemo") {
                                UIApplication.shared.open(url)
                            }
                        },
                        .default(Text("\(NSLocalizedString("Auto run when the app starts (Status: ", comment: ""))"+String(UserDefaults.standard.bool(forKey: "AutoRun"))+")")) {
                            if #available(iOS 15.0, *) {
                                if UserDefaults.standard.bool(forKey: "AutoRun") {
                                    UserDefaults.standard.set(false, forKey: "AutoRun")
                                }else {
                                    UserDefaults.standard.set(true, forKey: "AutoRun")
                                }
                            }
                            else {
                                notCompatibleWithIOS14 = true
                            }
                        },
                        .default(Text("\(NSLocalizedString("Run in background (Status: ", comment: ""))"+String(UserDefaults.standard.bool(forKey: "Location"))+")")) {
                            if UserDefaults.standard.bool(forKey: "Location") {
                                UserDefaults.standard.set(false, forKey: "Location")
                            }else {
                                UserDefaults.standard.set(true, forKey: "Location")
                            }
                            UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
                            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { _ in
                                        exit(0)
                                    }
                        },
                        .default(Text("\(NSLocalizedString("Location Indicator (Status: ", comment: ""))"+String(UserDefaults.standard.bool(forKey: "Location_Indicator"))+")")) {
                            if UserDefaults.standard.bool(forKey: "Location_Indicator") {
                                UserDefaults.standard.set(false, forKey: "Location_Indicator")
                            }else {
                                UserDefaults.standard.set(true, forKey: "Location_Indicator")
                            }
                            UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
                            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { _ in
                                        exit(0)
                                    }
                        },
                        .default(Text("\(NSLocalizedString("View Log (Status: ", comment: ""))"+String(UserDefaults.standard.bool(forKey: "ViewLog"))+")")) {
                            if UserDefaults.standard.bool(forKey: "ViewLog") {
                                UserDefaults.standard.set(false, forKey: "ViewLog")
                                viewLog = false
                            }else {
                                UserDefaults.standard.set(true, forKey: "ViewLog")
                                viewLog = true
                            }
                        },
                        .default(Text("\(NSLocalizedString("Update Check", comment: ""))")) {
                            let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
                            let url = URL(string: "https://api.github.com/repos/straight-tamago/NoCameraSound/releases/latest")
                            let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
                                guard let data = data else { return }
                                do {
                                    let object = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
                                    let latast_v = object["tag_name"]!
                                    if version != latast_v as! String {
                                        print("update")
                                        updateAvailable = true
                                        updateAlert = true
                                    }else{
                                        print("no update")
                                        updateAvailable = false
                                        updateAlert = true
                                    }
                                } catch {
                                    print(error)
                                }
                            }
                            task.resume()
                        },
                        .cancel()
                    ])
                }
                .alert(isPresented: $notCompatibleWithIOS14) {
                    Alert(title: Text("Not compatible with ios14"),
                          primaryButton: .destructive(Text("OK")),
                          secondaryButton: .default(Text("Cancel"))
                    )
                }
                .alert(isPresented: $updateAlert) {
                    if updateAvailable {
                        return Alert(title: Text("Update available"),
                              message: Text("Do you want to download the update from the Github ?"),
                              primaryButton: .destructive(Text("OK"),action: {
                            if let url = URL(string: "https://github.com/straight-tamago/NoCameraSound/releases") {
                                UIApplication.shared.open(url)
                            }
                        }),
                              secondaryButton: .default(Text("Cancel"))
                        )
                    }else{
                        return Alert(title: Text("No Update"),
                              dismissButton: .default(Text("OK"))
                        )
                    }
                }
            }
            if viewLog {
                    Text(logMessage)
                        .padding(.top, 10)
                        List {
                            ForEach(targetFilePathItems) { item in 
                              HStack {
                                Text(item.title)
                                Spacer()
                                  if isSucceeded(targetFilePath: "file://"+item.path) {
                                      Text(
                                        String("OFF")
                                      ).foregroundColor(.green)
                                  }else {
                                      Text(
                                          String("ON")
                                      ).foregroundColor(.red)
                                  }
                              }
                            }.frame(height: 1)
                        }
                    .listStyle(.plain)
                    .frame(width: 300, height: 200)
            }else {
                Text(logMessage)
                    .padding(.top, 10)
            }
        }.onAppear {
            logMessage = "v\(version)"
            if UserDefaults.standard.bool(forKey: "ViewLog") == false {
                viewLog = false
            }
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                print("List refresh")
                targetFilePathItems[0].id = UUID()
            }
            Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
                fileSwitchBackground()
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .background {
                print("バックグラウンド！")
            }
            if phase == .active {
                print("フォアグラウンド！")
                if UserDefaults.standard.bool(forKey: "AutoRun") {
                    disableShutterSound()
                    isShutterSoundDisabled = true
                }
            }
            if phase == .inactive {
                print("バックグラウンドorフォアグラウンド直前")
            }
        }
    }    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
