//
//  NoCameraSoundApp.swift
//  NoCameraSound
//
//  Created by straight-tamago★ on 2022/12/28.
//

import SwiftUI
import CoreLocation

@main
struct NoCameraSoundApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {
    var locationManager: CLLocationManager!

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions:
    [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)

        return true
    }
    
    @objc func appMovedToBackground() {
        print("App moved to background!")
        if UserDefaults.standard.bool(forKey: "Location") == true {
            locationManager = CLLocationManager()
            locationManager.requestAlwaysAuthorization()
            locationManager.showsBackgroundLocationIndicator = UserDefaults.standard.bool(forKey: "Location_Indicator")
            locationManager.distanceFilter = 1
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.allowsBackgroundLocationUpdates = true 
            locationManager.pausesLocationUpdatesAutomatically = false
            locationManager.delegate = self
            
            locationManager.startMonitoringSignificantLocationChanges()
            locationManager.startUpdatingLocation()
        }
    }
    @objc func appMovedToForeground() {
        print("App moved to foreground!")
        locationManager.stopMonitoringSignificantLocationChanges()
        locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("OK")
    }
}
