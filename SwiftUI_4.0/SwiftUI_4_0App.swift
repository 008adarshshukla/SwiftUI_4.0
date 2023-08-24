//
//  SwiftUI_4_0App.swift
//  SwiftUI_4.0
//
//  Created by Adarsh Shukla on 20/03/23.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct SwiftUI_4_0App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
//            NavigationStack {
//                RootView()
//            }
            TestingNavigation()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        print("Firebase Configured!")
        
        return true
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
}
