//
//  ContentView.swift
//  OneData Chat
//
//  Created by Apple on 03/10/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userVM: UserViewModel

    var body: some View {
        Group {
            if userVM.isLoggedIn {
                UserListView().environmentObject(userVM)
            } else {
                LoginView().environmentObject(userVM)
            }
        }
    }
}

#Preview {
    ContentView()
}
