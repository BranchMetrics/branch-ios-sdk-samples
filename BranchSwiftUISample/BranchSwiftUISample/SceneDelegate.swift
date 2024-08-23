//
//  SceneDelegate.swift
//  BranchSwiftUISample
//
//  Created by Nipun Singh on 11/1/23.
//


import SwiftUI
import BranchSDK

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: ContentView())
            self.window = window
            window.makeKeyAndVisible()
        }
        
        if let userActivity = connectionOptions.userActivities.first {
          BranchScene.shared().scene(scene, continue: userActivity)
        } else if !connectionOptions.urlContexts.isEmpty {
          BranchScene.shared().scene(scene, openURLContexts: connectionOptions.urlContexts)
        }
    }
    
    //Required to get the userActivity when using SwiftUI & SceneDelegate
    func scene(_ scene: UIScene, willContinueUserActivityWithType userActivityType: String) {
        scene.userActivity = NSUserActivity(activityType: userActivityType)
        scene.delegate = self
    }

    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        BranchScene.shared().scene(scene, continue: userActivity)
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        BranchScene.shared().scene(scene, openURLContexts: URLContexts)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
      
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
      
    }

    func sceneWillResignActive(_ scene: UIScene) {
      
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
      
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
      
    }

}
