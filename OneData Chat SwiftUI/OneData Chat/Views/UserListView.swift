//
//  UserListView.swift
//  OneData Chat
//
//  Created by Apple on 03/10/24.
//

import SwiftUI

struct UserListView: View {
    @EnvironmentObject var userVM: UserViewModel
    @State private var users: [User] = []
    @State private var showLogoutScreen = false // State to show logout screen

    var body: some View {
        NavigationView {
            List(users) { user in
                if let currentUser = userVM.currentUser, user.id != userVM.currentUser?.id {
                    NavigationLink(destination: ChatView(chatVM: ChatViewModel(currentUser: currentUser, chatPartner: user))) {
                        Text(user.username)
                    }
                }
            }
            .navigationBarTitle("Users")
            .navigationBarItems(trailing: Button(action: {
                showLogoutScreen.toggle() // Show the logout confirmation screen
            }) {
                Text("Logout")
                    .foregroundColor(.red)
            })
            .sheet(isPresented: $showLogoutScreen) {
                LogoutView() // Present the Logout confirmation screen
                    .environmentObject(userVM)
            }
            .onAppear(perform: loadUsers)
        }
    }

    private func loadUsers() {
        let db = DatabaseManager.shared
        do {
            let allUsers = try db.db!.prepare(db.users)
            users = allUsers.map { row in
                User(
                    id: row[db.userId],
                    username: row[db.username],
                    email: row[db.email],
                    password: row[db.password]
                )
            }
        } catch {
            print("Failed to load users: \(error)")
        }
    }
}


#Preview {
    UserListView()
}
