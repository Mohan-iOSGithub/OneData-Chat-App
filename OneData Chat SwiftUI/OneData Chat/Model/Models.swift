//
//  Untitled.swift
//  OneData Chat
//
//  Created by Apple on 03/10/24.
//

import Foundation

struct User: Identifiable {
    var id: Int64
    var username: String
    var email: String
    var password: String
}

struct Message: Identifiable {
    var id: Int64
    var senderId: Int64
    var receiverId: Int64
    var content: String
    var timestamp: Date
}

