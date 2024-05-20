//
//  ChatView.swift
//  WhiteboardAppFE
//
//  Created by Aditya Padia on 5/15/24.
//

import Foundation

import SwiftUI

struct ChatView: View {
    @State private var messages: [String] = ["Welcome to the chat"]
    @State private var newMessage: String = ""

    var body: some View {
        VStack {
            Text("Chat")
                .font(.headline)
            List(messages, id: \.self) { message in
                Text(message)
            }
            HStack {
                TextField("Type here...", text: $newMessage)
                Button(action: sendMessage) {
                    Text("Send")
                }
            }
            .padding()
        }
        .border(Color.black)
    }

    func sendMessage() {
        if !newMessage.isEmpty {
            messages.append(newMessage)
            newMessage = ""
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
