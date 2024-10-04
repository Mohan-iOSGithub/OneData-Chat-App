//
//  LogoutView.swift
//  OneData Chat
//
//  Created by Apple on 03/10/24.
//

import SwiftUI

struct LogoutView: View {
    @EnvironmentObject var userVM: UserViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Are you sure you want to log out?")
                .font(.headline)
                .padding()

            HStack {
                Button(action: {
                    userVM.logout() // Call logout
                    presentationMode.wrappedValue.dismiss() // Close the view
                }) {
                    Text("Logout")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(8)
                }

                Button(action: {
                    presentationMode.wrappedValue.dismiss() // Close the view
                }) {
                    Text("Cancel")
                        .foregroundColor(.blue)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                }
            }
            .padding()
        }
    }
}

#Preview {
    LogoutView()
}
