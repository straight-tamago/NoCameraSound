import SwiftUI
import AudioToolbox

extension ContentView {
    func disableShutterSound() {
        performSoundOperation(log: "Disabling...", data: "xxx")
    }
    
    func restoreShutterSoundSP() {
        isShutterSoundDisabled = false
        restoreShutterSound()
    }
    
    func restoreShutterSound() {
        performSoundOperation(log: "Restoring...", data: "caf")
    }
    
    private func performSoundOperation(log: String, data: String) {
        logMessage = log
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        for i in 0..<5 {
            DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(i/10)) {
                targetFilePathItems.forEach {
                    logMessage = overwrite(targetFilePath: $0.path, overwriteData: data)
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            targetFilePathItems.forEach {
                logMessage = overwrite(targetFilePath: $0.path, overwriteData: data)
            }
        }
    }
    
    func fileSwitchBackground() -> (Void) {
        print("FileSwitch_background")
        if UserDefaults.standard.bool(forKey: "Location") == true {
            if isShutterSoundDisabled == true {
                disableShutterSound()
            }
        }
    }
}
