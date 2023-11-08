//
//  AppDelegate.swift
//  BranchSwiftUISample
//
//  Created by Nipun Singh on 11/1/23.
//

import SwiftUI
import BranchSDK

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        Branch.getInstance().enableLogging()

        BranchScene.shared().initSession(launchOptions: launchOptions, registerDeepLinkHandler: { (params, error, scene) in
            print("Deeplink Data: \(params as? [String: AnyObject] ?? [:])")
        })
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)

    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session
        // If any sessions were discarded while the application was not running, this will be called shortly after `application:didFinishLaunchingWithOptions`
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return
    }

}

