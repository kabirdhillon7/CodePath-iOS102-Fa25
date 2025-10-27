//
//  SendMessageView.swift
//  FireChat
//
//  Created by Kabir Dhillon on 10/26/25.
//

import SwiftUI

struct SendMessageView: View {
    var onSend: (String) -> Void // <-- Closure called with a message passed in when send message button is tapped

    @State private var messageText: String = "" // <-- Local state managed var to hold the message text as user types

    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            TextField("Message", text: $messageText, axis: .vertical) // <-- Message text field
                .padding(.leading)
                .padding(.trailing, 4)
                .padding(.vertical, 8)

            // Send message button
            Button {
                onSend(messageText) // <-- Call onSend closure passing in the message text when send button is tapped
                messageText = "" // <-- Clear the message text after being sent
            } label: {
                Image(systemName: "arrow.up.circle.fill") // <-- Use arrow image from SFSymbols
                    .resizable()
                    .frame(width: 30, height: 30)
                    .bold()
                    .padding(4)
            }
            .disabled(messageText.isEmpty) // <-- Disable button if text is empty
        }
        .overlay(RoundedRectangle(cornerRadius: 19).stroke(Color(uiColor: .systemGray2)))
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(.thickMaterial) // <-- Add material to background
        //        .focused($isMessageFieldFocused)
    }
}
