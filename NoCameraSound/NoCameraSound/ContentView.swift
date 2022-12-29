//
//  ContentView.swift
//  NoCameraSound
//
//  Created by すとれーとたまご★ on 2022/12/28.
//

import SwiftUI

struct ContentView: View {
    private let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    @State private var LogMessage = ""
    @State private var LogText = ""
    @State private var ViewLog = true
    @State private var SettingsShowing = false
    @State private var ios14Warning = false
    var body: some View {
        VStack {
            if ViewLog {
                Text("")
                    .frame(width: 300, height: 200)
                    .padding()
                    .disabled(true)
            }
            Text("NoCameraSound").font(.largeTitle).fontWeight(.bold)
            HStack {
                Button("Disable Shutter Sound") {
                    if #available(iOS 15.0, *) {
                        LogText = ""
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
                            if UserDefaults.standard.bool(forKey: "AutoRun") == true {
                                UserDefaults.standard.set(false, forKey: "AutoRun")
                            }else {
                                UserDefaults.standard.set(true, forKey: "AutoRun")
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
                        .default(Text("\(NSLocalizedString("Camera silent + English notation (JP Only) (Status: ", comment: ""))"+String(UserDefaults.standard.bool(forKey: "Visibility"))+")")) {
                            if Locale.preferredLanguages.first! == "ja-JP" {
                                if UserDefaults.standard.bool(forKey: "Visibility") == true {
                                    UserDefaults.standard.set(false, forKey: "Visibility")
                                }else {
                                    UserDefaults.standard.set(true, forKey: "Visibility")
                                }
                            }
                        },
                        .cancel()
                    ])
                }
            }
            if ViewLog {
                ScrollViewReader { reader in
                    ScrollView {
                        Text(LogText)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(10)
                            .id(30)
                            .onChange(of: LogText) { newValue in
                                withAnimation (.easeInOut){
                                    reader.scrollTo(30)
                                }
                            }
                    }
                    .frame(width: 300, height: 200)
                    .border(Color.black, width: 1)
                    .padding()
                }
                Text(LogMessage)
                    .padding()
            }else {
                Text(LogMessage)
                    .padding()
            }
        }.onAppear {
            LogText = "NoCameraSound v\(version) by straight-tamago"+"\n"
            if UserDefaults.standard.bool(forKey: "AutoRun") == true {
                LogText = ""
                LogText += "(AutoRun)"+"\n"
                disable_shuttersound()
            }
            if UserDefaults.standard.bool(forKey: "ViewLog") == false {
                ViewLog = false
            }
        }
    }
    
    
    
//    ---------------------------------------------------------------------------------------
    func disable_shuttersound() {
        LogText += "NoCameraSound v\(version) by straight-tamago"+"\n"
        LogText += "\nDisabling Shutter Sound..."
        ac()
        ac()
        ac()
        ac()
        ac()
    }
    
    func ac() {
        overwriteAsync(TargetFilePath: "/System/Library/Audio/UISounds/photoShutter.caf") {
            LogText += "\nphotoShutter.caf \n- "+$0
            LogMessage = $0
            overwriteAsync(TargetFilePath: "/System/Library/Audio/UISounds/begin_record.caf") {
                LogText += "\nbegin_record.caf \n- "+$0
                LogMessage = $0
                overwriteAsync(TargetFilePath: "/System/Library/Audio/UISounds/end_record.caf") {
                    LogText += "\nend_record.caf \n- "+$0
                    LogMessage = $0
                    overwriteAsync(TargetFilePath: "/System/Library/Audio/UISounds/Modern/camera_shutter_burst.caf") {
                        LogText += "\ncamera_shutter_burst.caf \n- "+$0
                        LogMessage = $0
                        overwriteAsync(TargetFilePath: "/System/Library/Audio/UISounds/Modern/camera_shutter_burst_begin.caf") {
                            LogText += "\ncamera_shutter_burst_begin.caf \n- "+$0
                            LogMessage = $0
                            overwriteAsync(TargetFilePath: "/System/Library/Audio/UISounds/Modern/camera_shutter_burst_end.caf") {
                                LogText += "\ncamera_shutter_burst_end.caf \n- "+$0
                                LogMessage = $0
                                if UserDefaults.standard.bool(forKey: "Visibility") == true && Locale.preferredLanguages.first! == "ja-JP" {
                                    overwriteAsync(TargetFilePath: "/System/Library/PrivateFrameworks/CameraUI.framework/ja.lproj/CameraUI.strings") {
                                        LogText += "\nCameraUI.strings \n- "+$0
                                        LogMessage = $0
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
