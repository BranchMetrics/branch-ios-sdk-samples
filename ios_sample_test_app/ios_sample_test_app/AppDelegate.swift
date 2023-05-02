//
//  AppDelegate.swift
//  ios_sample_test_app
//
//  Created by Brandon Boothe on 3/23/23.
//

import UIKit

import BranchSDK

@main 
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var navigationcontroller: UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //See Branch Logs
        Branch.getInstance().enableLogging()
        
        // This version of initSession includes the source UIScene in the callback
        BranchScene.shared().initSession(launchOptions: launchOptions, registerDeepLinkHandler: { (params, error, scene) in
            
            guard let data = params as? [String: AnyObject] else { return }
            
            guard let options = data["nav_to"] as? String else { return }
            
            let rootViewController = UIApplication.shared.windows.first?.rootViewController as? UINavigationController

            switch options {
            case "color_block_page":
                rootViewController?.pushViewController(ColorBlockViewController(), animated: true)
                
            case "read_deep_link_page":
                rootViewController?.pushViewController(ReadDeepLinkViewController(), animated: true)
                
            default: break
            }
        })
        
        // login
        Branch.getInstance().setIdentity("your_user_id")
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}
