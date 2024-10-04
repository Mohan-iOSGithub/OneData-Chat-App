//
//  ChatViewModel.swift
//  OneData Chat
//
//  Created by Apple on 03/10/24.
//

import Foundation
import Combine

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var newMessageContent: String = ""

    private let db = DatabaseManager.shared
    private var cancellables = Set<AnyCancellable>()

    var currentUser: User
    var chatPartner: User

    init(currentUser: User, chatPartner: User) {
        self.currentUser = currentUser
        self.chatPartner = chatPartner
        loadMessages()
    }

    func loadMessages() {
        messages = db.getMessages(between: currentUser.id, and: chatPartner.id)
    }

    func sendMessage() {
        guard !newMessageContent.isEmpty else { return }

        if db.addMessage(senderId: currentUser.id, receiverId: chatPartner.id, content: newMessageContent) {
            loadMessages()
            newMessageContent = ""
        }
    }
}
