//
//  LoginView.swift
//  OneData Chat
//
//  Created by Apple on 03/10/24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var userVM: UserViewModel
    @State private var username = ""
    @State private var password = ""
    @State private var showingRegistration = false

    var body: some View {
        VStack {
            Text("Login").font(.largeTitle).padding()
 
            TextField("Username", text: $username)
                .autocapitalization(.none)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(5.0)

            SecureField("Password", text: $password)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(5.0)

            if let errorMessage = userVM.errorMessage {
                Text(errorMessage).foregroundColor(.red)
            }

            Button(action: {
                userVM.login(username: username, password: password)
            }) {
                Text("Login")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.green)
                    .cornerRadius(15.0)
            }.padding()

            Button(action: {
                showingRegistration = true
            }) {
                Text("Don't have an account? Register")
            }.sheet(isPresented: $showingRegistration) {
                RegistrationView().environmentObject(userVM)
            }
        }
        .padding()
    }
}

#Preview {
    LoginView()
}
