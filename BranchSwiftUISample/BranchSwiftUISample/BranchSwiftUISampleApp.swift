//
//  BranchSwiftUISampleApp.swift
//  BranchSwiftUISample
//
//  Created by Nipun Singh on 11/1/23.
//

import SwiftUI
import BranchSDK

@main
struct BranchSwiftUISampleApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL(perform: { url in
                    Branch.getInstance().handleDeepLink(url)
                })
            
        }
        
    }
}
