//
//  RegistrationView.swift
//  OneData Chat
//
//  Created by Apple on 03/10/24.
//

import SwiftUI

struct RegistrationView: View {
    @EnvironmentObject var userVM: UserViewModel
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack {
            Text("Register").font(.largeTitle).padding()

            TextField("Username", text: $username)
                .autocapitalization(.none)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(5.0)

            TextField("Email", text: $email)
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
                userVM.register(username: username, email: email, password: password)
            }) {
                Text("Register")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.blue)
                    .cornerRadius(15.0)
            }.padding()
        }
        .padding()
    }
}


#Preview {
    RegistrationView()
}
