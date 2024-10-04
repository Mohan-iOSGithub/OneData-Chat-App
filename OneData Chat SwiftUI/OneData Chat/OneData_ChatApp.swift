//
//  OneData_ChatApp.swift
//  OneData Chat
//
//  Created by Apple on 03/10/24.
//

import SwiftUI

@main
struct SwiftUIChatApp: App {
    @StateObject var userVM = UserViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(userVM)
        }
    }
}
