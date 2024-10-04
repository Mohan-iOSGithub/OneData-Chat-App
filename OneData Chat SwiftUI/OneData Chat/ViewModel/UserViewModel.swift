//
//  UserViewModel.swift
//  OneData Chat
//
//  Created by Apple on 03/10/24.
//

import Foundation
import Combine

class UserViewModel: ObservableObject {
    @Published var isLoggedIn = false
    @Published var currentUser: User?
    @Published var errorMessage: String?

    private let db = DatabaseManager.shared

    func register(username: String, email: String, password: String) {
        if db.addUser(username: username, email: email, password: password) {
            // Registration successful
            currentUser = db.getUser(username: username)
            isLoggedIn = true
        } else {
            errorMessage = "Registration failed. Username might be taken."
        }
    }

    func login(username: String, password: String) {
        if let user = db.authenticateUser(username: username, password: password) {
            currentUser = user
            isLoggedIn = true
        } else {
            errorMessage = "Login failed. Check your credentials."
        }
    }

    func logout() {
        currentUser = nil
        isLoggedIn = false
    }
}
