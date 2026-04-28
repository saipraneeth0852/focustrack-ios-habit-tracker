//
//  ArchitecturesSwiftUIApp.swift
//  ArchitecturesSwiftUI
//
//  Created by Frédéric Helfer on 05/02/23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct ArchitecturesSwiftUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if appState.isAuthorized {
                    HomeView()
                        .transition(AnyTransition.slide.animation(.easeInOut))
                } else {
                    LoginView()
                        .transition(AnyTransition.opacity.animation(.easeInOut))
                }
            }
            .environmentObject(appState)
        }
    }
}
