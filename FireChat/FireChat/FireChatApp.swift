//
//  FireChatApp.swift
//  FireChat
//
//  Created by Kabir Dhillon on 10/26/25.
//

import SwiftUI
import FirebaseCore

@main
struct FireChatApp: App {
    
    @State private var authManager: AuthManager
    
    init() {
        FirebaseApp.configure()
        authManager = AuthManager()
        
    }
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
//            LoginView()
//                .environment(authManager)
            if authManager.user != nil { // <-- Check if you have a non-nil user (means there is a logged in user)
                
                // We have a logged in user, go to ChatView
                ChatView()
                    .environment(authManager)
            } else {
                
                // No logged in user, go to LoginView
                LoginView()
                    .environment(authManager)
            }
        }
    }
}
