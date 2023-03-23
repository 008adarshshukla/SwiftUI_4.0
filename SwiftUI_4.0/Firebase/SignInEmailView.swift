//
//  SignInEmailView.swift
//  SwiftUI_4.0
//
//  Created by Adarsh Shukla on 23/03/23.
//

import SwiftUI

@MainActor
final class SignInEmailViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    func signIn() {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        
        Task {
            do {
                let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
                print("Succes in Signing In")
                print(returnedUserData)
            } catch (let error) {
                print(error.localizedDescription)
            }
        }
    }
}

struct SignInEmailView: View {
    
    @StateObject private var viewModel = SignInEmailViewModel()
    
    var body: some View {
        VStack {
            TextField("Email...", text: $viewModel.email)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .padding()
                .background {
                    Color.gray.opacity(0.4)
                }
                .cornerRadius(10)
            
            SecureField("Password...", text: $viewModel.password)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .padding()
                .background {
                    Color.gray.opacity(0.4)
                }
                .cornerRadius(10)
            
            Spacer()
            
            Button {
                viewModel.signIn()
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background {
                        Color.blue
                    }
                    .cornerRadius(10)
            }

        }
        .padding()
        .navigationTitle("Sign In With Email")
    }
}

struct SignInEmailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignInEmailView()
        }
    }
}
