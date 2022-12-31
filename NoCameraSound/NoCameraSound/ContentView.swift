//
//  ContentView.swift
//  NoCameraSound
//
//  Created by straight-tamago★ on 2022/12/28.
//

import SwiftUI

struct ContentView: View {
    private let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    @State private var LogMessage = ""
    @State private var ViewLog = true
    @State private var SettingsShowing = false
    @State private var ios14Warning = false
    @State private var Rerun = false
    @State private var UpdateAlert = false
    @State private var NoUpdateAlert = false
    @State private var Notcompatiblewithios14 = false
    struct TargetFilesPath_Struct: Identifiable {
      var  id = UUID()
      let title: String
      let path: String
    }
    @State private var TargetFilesPath = [
        TargetFilesPath_Struct(
            title: "photoShutter.caf",
            path: "/System/Library/Audio/UISounds/photoShutter.caf"
        ),
        TargetFilesPath_Struct(
            title: "begin_record.caf",
            path: "/System/Library/Audio/UISounds/begin_record.caf"
        ),
        TargetFilesPath_Struct(
            title: "end_record.caf",
            path: "/System/Library/Audio/UISounds/end_record.caf"
        ),
        TargetFilesPath_Struct(
            title: "camera_shutter_burst.caf",
            path: "/System/Library/Audio/UISounds/Modern/camera_shutter_burst.caf"
        ),
        TargetFilesPath_Struct(
            title: "camera_shutter_burst_begin.caf",
            path: "/System/Library/Audio/UISounds/Modern/camera_shutter_burst_begin.caf"
        ),
        TargetFilesPath_Struct(
            title: "camera_shutter_burst_end.caf",
            path: "/System/Library/Audio/UISounds/Modern/camera_shutter_burst_end.caf"
        ),
    ]
    var body: some View {
        VStack {
            if ViewLog {
                Text("")
                    .frame(width: 300, height: 200)
                    .padding(.top, 10)
                    .disabled(true)
            }
            Text("NoCameraSound").font(.largeTitle).fontWeight(.bold)
            HStack {
                //---------------------------------------------------------------------------
                if TargetFilesPath.allSatisfy { IsSucceeded(TargetFilePath: "file://"+$0.path) == true } == false {
                    Button("Disable Shutter Sound") {
                        if #available(iOS 15.0, *) {
                            disable_shuttersound()
                        }
                        else {
                            ios14Warning = true
                        }
                    }
                    .padding()
                    .accentColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(26)
                    .shadow(color: Color.purple, radius: 15, x: 0, y: 5)
                    .alert(isPresented: $ios14Warning) {
                        Alert(title: Text("IOS14 Warning"),
                              message: Text("In iOS14, once executed, it will not revert."),
                              primaryButton: .destructive(Text("Run"),action: disable_shuttersound),
                              secondaryButton: .default(Text("Cancel"))
                        )
                    }
                }
                else {
                    Button("Disabled Shutter Sound") {
                        Rerun = true
                    }
                    .padding()
                    .accentColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(26)
                    .shadow(color: Color.purple, radius: 15, x: 0, y: 5)
                    .alert(isPresented: $Rerun) {
                        Alert(title: Text("Disabled Shutter Sound"),
                              message: Text("Rerun"),
                              primaryButton: .destructive(Text("Run"),action: disable_shuttersound),
                              secondaryButton: .default(Text("Cancel"))
                        )
                    }
                }
                //---------------------------------------------------------------------------
                Button {
                    SettingsShowing = true
                } label: {
                    Image(systemName: "info.circle")
                        .padding()
                        .accentColor(Color.white)
                        .background(Color.blue)
                        .cornerRadius(26)
                        .shadow(color: Color.purple, radius: 15, x: 0, y: 5)
                }.actionSheet(isPresented: $SettingsShowing) {
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
                                if UserDefaults.standard.bool(forKey: "AutoRun") == true {
                                    UserDefaults.standard.set(false, forKey: "AutoRun")
                                }else {
                                    UserDefaults.standard.set(true, forKey: "AutoRun")
                                }
                            }
                            else {
                                Notcompatiblewithios14 = true
                            }
                        },
                        .default(Text("\(NSLocalizedString("View Log (Status: ", comment: ""))"+String(UserDefaults.standard.bool(forKey: "ViewLog"))+")")) {
                            if UserDefaults.standard.bool(forKey: "ViewLog") == true {
                                UserDefaults.standard.set(false, forKey: "ViewLog")
                                ViewLog = false
                            }else {
                                UserDefaults.standard.set(true, forKey: "ViewLog")
                                ViewLog = true
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
                                        UpdateAlert = true
                                        NoUpdateAlert = true
                                        return
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
                .alert(isPresented: $Notcompatiblewithios14) {
                    Alert(title: Text("Not　compatible　with　ios14"),
                          primaryButton: .destructive(Text("OK")),
                          secondaryButton: .default(Text("Cancel"))
                    )
                }
                .alert(isPresented: $UpdateAlert) {
                    Alert(title: Text("Update available"),
                          message: Text("Do you want to download the update from the Github ?"),
                          primaryButton: .destructive(Text("OK"),action: {
                        if let url = URL(string: "https://github.com/straight-tamago/NoCameraSound/releases") {
                            UIApplication.shared.open(url)
                        }
                    }),
                          secondaryButton: .default(Text("Cancel"))
                    )
                }
                .alert(isPresented: $NoUpdateAlert) {
                    Alert(title: Text("No Update"),
                          dismissButton: .destructive(Text("OK"))
                    )
                }
                //---------------------------------------------------------------------------
            }
            if ViewLog {
                    Text(LogMessage)
                        .padding(.top, 10)
                        List {
                            ForEach(TargetFilesPath) { item in
                              HStack {
                                Text(item.title)
                                Spacer()
                                  if IsSucceeded(TargetFilePath: "file://"+item.path) == true {
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
                Text(LogMessage)
                    .padding(.top, 10)
            }
        }.onAppear {
            LogMessage = "v\(version)"
            if UserDefaults.standard.bool(forKey: "AutoRun") == true {
                disable_shuttersound()
            }
            if UserDefaults.standard.bool(forKey: "ViewLog") == false {
                ViewLog = false
            }
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                // なぜか更新されないから無理矢理
                // 多分osが勝手にやってるから
                print("List refresh")
                TargetFilesPath[0].id = UUID()
            }
        }
    }
    
    
    //    ---------------------------------------------------------------------------------------
    func disable_shuttersound() {
        LogMessage = "Disabling..."
        TargetFilesPath.forEach {
            LogMessage = overwrite(TargetFilePath: $0.path)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
