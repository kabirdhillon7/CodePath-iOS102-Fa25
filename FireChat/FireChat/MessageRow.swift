//
//  MessageRow.swift
//  FireChat
//
//  Created by Kabir Dhillon on 10/26/25.
//

import SwiftUI

struct MessageRow: View {
    let text: String // <-- The message text
    let isOutgoing: Bool // <-- true if sent by the current user

    var body: some View {
        HStack {
            if isOutgoing {
                Spacer() // <-- Spacer shifts message bubble to the right for outgoing messages
            }
            messageBubble // <-- The message bubble
            if !isOutgoing {
                Spacer() // <-- Spacer shifts message bubble to the left for incoming messages
            }
        }
    }

    private var messageBubble: some View {
        Text(text)
            .fixedSize(horizontal: false, vertical: true) // <-- Allow message text to expand and wrap vertically if needed
            .foregroundStyle(isOutgoing ? .white : .primary) // <-- Set the text color based on outgoing status
            .padding(.vertical, 10)
            .padding(.horizontal, 12)
            .background(
                RoundedRectangle(cornerRadius: 20.0) // <-- Add bubble shape to the background
                    .fill(isOutgoing ? Color.blue.gradient : Color(.systemGray5).gradient) // <-- Set bubble color based on outgoing status
            )
            .padding(isOutgoing ? .trailing : .leading, 12) // <-- Set padding based on outgoing status
            .containerRelativeFrame(.horizontal, count: 7, span: 5, spacing: 0, alignment: isOutgoing ? .trailing : .leading) // <-- Set message size relative to container (the scroll view width in this case)
    }
}
