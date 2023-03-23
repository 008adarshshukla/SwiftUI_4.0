//
//  SwiftUI_4_0App.swift
//  SwiftUI_4.0
//
//  Created by Adarsh Shukla on 20/03/23.
//

import SwiftUI
import Firebase

@main
struct SwiftUI_4_0App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        print("Firebase Configured!")
        
        return true
    }
}
