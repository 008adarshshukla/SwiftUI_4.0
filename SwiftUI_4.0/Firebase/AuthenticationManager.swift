//
//  AuthenticationManager.swift
//  SwiftUI_4.0
//
//  Created by Adarsh Shukla on 23/03/23.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}

final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    
    private init() {
        
    }
    
    //returns the current user that is autheticated from the current session.
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
    }
    
    
    
    //sign Out
    func signOut() throws {
        try Auth.auth().signOut()
    }
}

//MARK: Sign in email
extension AuthenticationManager {
    //signs up the user
    @discardableResult
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        let result = AuthDataResultModel(user: authDataResult.user)
        return result
    }
    
    //sign in the user
    @discardableResult
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        let result = AuthDataResultModel(user: authDataResult.user)
        return result
    }
    
    //Reset the password
    func resetPassword(email : String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    //Upadate password.
    func updatePassword(newPassword: String) async throws {
        //we need to be sugned in to update the password.
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        try await user.updatePassword(to: newPassword)
    }
    
    //Upadate email.
    func updateEmail(newEmail: String) async throws {
        //we need to be sugned in to update the password.
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        try await user.updateEmail(to: newEmail)
    }
}


//MARK: Sign in SSOG
extension AuthenticationManager {
    
    //MARK: Add a field GIDClientID in info.plist file of the app. We can get the value from GoogleServicesInfo. plist file with key as CLIENT_ID.
    
    @discardableResult
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        return try await signIn(credential: credential)
    }
    
    func signIn(credential: AuthCredential) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(with: credential)
        return AuthDataResultModel(user: authDataResult.user)
    }
}
