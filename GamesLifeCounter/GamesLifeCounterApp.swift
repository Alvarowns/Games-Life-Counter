//
//  GamesLifeCounterApp.swift
//  GamesLifeCounter
//
//  Created by Alvaro Santos Orellana on 26/4/24.
//

import SwiftUI
import SwiftData
import GoogleMobileAds

class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    GADMobileAds.sharedInstance().start(completionHandler: nil)

    return true
  }
}

@main
struct GamesLifeCounterApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var viewModel = MainViewVM()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(MainViewVM())
        .modelContainer(for: Matches.self)
        
    }
}
