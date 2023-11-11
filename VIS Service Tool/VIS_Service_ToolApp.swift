//
//  VIS_Service_ToolApp.swift
//  VIS Service Tool
//
//  Created by Matt Reid on 12/9/2022.
//

import SwiftUI

@main

struct VISServiceToolApp: App {
@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var motionDetector = MotionDetector(updateInterval: 0.01)
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(motionDetector)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    static var orientationLock = UIInterfaceOrientationMask.portrait
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window:UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}
