//
//  DatabaseManager.swift
//  OneData Chat
//
//  Created by Apple on 03/10/24.
//

import Foundation
import SQLite
import SwiftUI

class DatabaseManager {
    static var shared = DatabaseManager()
    var db: Connection?

    // MARK: - Tables
    var users = Table("users")
    var messages = Table("messages")

    // MARK: - User Columns
    var userId = SQLite.Expression<Int64>("user_id")
    var username = SQLite.Expression<String>("username")
    var email = SQLite.Expression<String>("email")
    var password = SQLite.Expression<String>("password")

    // MARK: - Message Columns
    var messageId = SQLite.Expression<Int64>("message_id")
    var senderId = SQLite.Expression<Int64>("sender_id")
    var receiverId = SQLite.Expression<Int64>("receiver_id")
    var content = SQLite.Expression<String>("content")
    var timestamp = SQLite.Expression<Date>("timestamp")

    private init() {
        connectToDatabase()
    }

    func connectToDatabase() {
        do {
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            db = try Connection("\(path)/chatApp.sqlite3")
            createTables()
        } catch {
            print("Unable to open database. Error: \(error)")
        }
    }

    // Create tables if they don't exist
    private func createTables() {
        do {
            try db?.run(users.create(ifNotExists: true) { table in
                table.column(userId, primaryKey: true)
                table.column(username)
                table.column(email, unique: true)
                table.column(password)
            })

            try db?.run(messages.create(ifNotExists: true) { table in
                table.column(messageId, primaryKey: true)
                table.column(senderId)
                table.column(receiverId)
                table.column(content)
                table.column(timestamp)
            })
        } catch {
            print("Failed to create tables: \(error)")
        }
    }
}

extension DatabaseManager {
    // Register a new user
    @discardableResult
    func addUser(username: String, email: String, password: String) -> Bool {
        let insert = users.insert(self.username <- username, self.email <- email, self.password <- password)
        do {
            try db?.run(insert)
            print("User added successfully")
            return true // Return true on successful insertion
        } catch {
            print("Error adding user: \(error)")
            return false // Return false on error
        }
    }

    // Fetch a user by username
    func getUser(username: String) -> User? {
        do {
            if let userRow = try db?.pluck(users.filter(self.username == username)) {
                return User(
                    id: userRow[userId],
                    username: userRow[self.username],
                    email: userRow[email],
                    password: userRow[password]
                )
            }
        } catch {
            print("Fetch user failed: \(error)")
        }
        return nil
    }

    // Authenticate user
    func authenticateUser(username: String, password: String) -> User? {
        if let user = getUser(username: username), user.password == password {
            return user
        }
        return nil
    }
}


extension DatabaseManager {
    // Send a message
    func addMessage(senderId: Int64, receiverId: Int64, content: String) -> Bool {
        do {
            let insert = messages.insert(
                self.senderId <- senderId,
                self.receiverId <- receiverId,
                self.content <- content,
                self.timestamp <- Date()
            )
            try db?.run(insert)
            return true
        } catch {
            print("Insert message failed: \(error)")
            return false
        }
    }

    // Fetch messages between two users
    func getMessages(between userId1: Int64, and userId2: Int64) -> [Message] {
        var fetchedMessages = [Message]()
        do {
            let query = messages.filter(
                (senderId == userId1 && receiverId == userId2) ||
                (senderId == userId2 && receiverId == userId1)
            ).order(timestamp.asc)

            for message in try db!.prepare(query) {
                let msg = Message(
                    id: message[messageId],
                    senderId: message[senderId],
                    receiverId: message[receiverId],
                    content: message[content],
                    timestamp: message[timestamp]
                )
                fetchedMessages.append(msg)
            }
        } catch {
            print("Fetch messages failed: \(error)")
        }
        return fetchedMessages
    }
}
