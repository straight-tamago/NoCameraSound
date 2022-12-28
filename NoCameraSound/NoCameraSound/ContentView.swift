//
//  ContentView.swift
//  NoCameraSound
//
//  Created by すとれーとたまご★ on 2022/12/28.
//

import SwiftUI

struct ContentView: View {
    let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    @State private var message = ""
    @State private var showingAlert = false
    var body: some View {
        VStack {
          Text("NoCameraSound").font(.largeTitle).fontWeight(.bold)
            HStack {
                Button("Disable Shutter Sound") {
                    ac()
                    ac()
                    ac()
                    ac()
                    ac()
                }
                .padding()
                .accentColor(Color.white)
                .background(Color.blue)
                .cornerRadius(26)
                .shadow(color: Color.purple, radius: 15, x: 0, y: 5)
                
                Button {
                    showingAlert = true
                } label: {
                    Image(systemName: "info.circle")
                        .padding()
                        .accentColor(Color.white)
                        .background(Color.blue)
                        .cornerRadius(26)
                        .shadow(color: Color.purple, radius: 15, x: 0, y: 5)
                }.actionSheet(isPresented: $showingAlert) {
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
                        .default(Text("Autorun at startup (Status: "+String(UserDefaults.standard.bool(forKey: "AutoRun"))+")")) {
                            if UserDefaults.standard.bool(forKey: "AutoRun") == true {
                                UserDefaults.standard.set(false, forKey: "AutoRun")
                            }else {
                                UserDefaults.standard.set(true, forKey: "AutoRun")
                            }
                        },
                        .cancel()
                    ])
                }
            }
          Text(message).padding(16)
        }.onAppear {
            if UserDefaults.standard.bool(forKey: "AutoRun") == true {
                ac()
                ac()
                ac()
                ac()
                ac()
            }
        }
    }
    func ac() {
        message = "photoShutter.caf"
        overwriteAsync(path: "/System/Library/Audio/UISounds/photoShutter.caf") {
            message = $0
        }
        message = "begin_record.caf"
        overwriteAsync(path: "/System/Library/Audio/UISounds/begin_record.caf") {
            message = $0
        }
        message = "end_record.caf"
        overwriteAsync(path: "/System/Library/Audio/UISounds/end_record.caf") {
            message = $0
        }
        message = "end_record.caf"
        overwriteAsync(path: "/System/Library/Audio/UISounds/Modern/camera_shutter_burst.caf") {
            message = $0
        }
        message = "end_record.caf"
        overwriteAsync(path: "/System/Library/Audio/UISounds/Modern/camera_shutter_burst_begin.caf") {
            message = $0
        }
        message = "end_record.caf"
        overwriteAsync(path: "/System/Library/Audio/UISounds/Modern/camera_shutter_burst_end.caf") {
            message = $0
        }
    }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
