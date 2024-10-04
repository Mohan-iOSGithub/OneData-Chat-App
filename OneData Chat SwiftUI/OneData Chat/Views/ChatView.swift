//
//  ChatView.swift
//  OneData Chat
//
//  Created by Apple on 03/10/24.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var chatVM: ChatViewModel

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(chatVM.messages) { message in
                        HStack {
                            if message.senderId == chatVM.currentUser.id {
                                Spacer()
                                Text(message.content)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(10)
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                            } else {
                                Text(message.content)
                                    .padding()
                                    .background(Color.gray)
                                    .cornerRadius(10)
                                    .foregroundColor(.black)
                                    .padding(.horizontal)
                                Spacer()
                            }
                        }
                    }
                }
            }

            HStack {
                TextField("Message", text: $chatVM.newMessageContent)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minHeight: CGFloat(30))

                Button(action: {
                    chatVM.sendMessage()
                }) {
                    Text("Send")
                }
            }
            .padding()
        }
        .navigationBarTitle(chatVM.chatPartner.username, displayMode: .inline)
        .onAppear(perform: chatVM.loadMessages)
    }
}

#Preview {
    ChatView(chatVM: ChatViewModel(currentUser: .init(id: 100, username: "Mohan", email: "mohan@gmail.com", password: "Test@123"), chatPartner: .init(id: 101, username: "KArthikeeyan", email: "mohan@gmail.com", password: "Test@123")))
}
