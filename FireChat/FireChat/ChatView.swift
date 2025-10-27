//
//  ChatView.swift
//  FireChat
//
//  Created by Kabir Dhillon on 10/26/25.
//

import SwiftUI

struct ChatView: View {

    // TODO: Access authManager from the environment
    @Environment(AuthManager.self) var authManager
    
    @State var messageManager: MessageManager

    init(isMocked: Bool = false) {
        messageManager = MessageManager(isMocked: isMocked)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView { // <-- Add ScrollView
                VStack { // <-- Add VStack
                    ForEach(messageManager.messages) { message in
                        MessageRow(text: message.text, isOutgoing: authManager.userEmail == message.username)
                    }

                }
            }
            .defaultScrollAnchor(.bottom)
            .navigationTitle("Chat")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button("Sign out") {
                        authManager.signOut()
                    }
                }
            }
            .safeAreaInset(edge: .bottom) { // <-- Add safeAreaInset modifier to add and display send message view above the bottom safe area
                SendMessageView { messageText in // <-- Add SendMessageView
                    // TODO: Save message to Firestore
                        messageManager.sendMessage(text: messageText, username: authManager.userEmail ?? "")
                }
            }
        }
    }
}

#Preview {
    ChatView(isMocked: true)
        .environment(AuthManager(isMocked: true))
}
