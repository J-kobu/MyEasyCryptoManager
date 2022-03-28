//
//  AuthenticationDatasource.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 27-03-22.
//

import Foundation
import FirebaseAuth


final class AuthenticationFirebaseDatasource {
    
    func getCurrentUser() -> UserModel? {
        guard let email = Auth.auth().currentUser?.email else {
            return nil
        }
        return .init(email: email)
    }
    
    func createNewUser(email: String, password: String, completionBlock: @escaping (Result<UserModel, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in
            if let error = error {
                print("Error creating new user \(error.localizedDescription)")
                completionBlock(.failure(error))
                return
            }
            let email = authDataResult?.user.email ?? "No email"
            print("New user creted with info \(email)")
            completionBlock(.success(.init(email: email)))
        }
    }
    
    func signin(email: String, password: String, completionBlock: @escaping (Result<UserModel, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
            if let error = error {
                print("Error login \(error.localizedDescription)")
                completionBlock(.failure(error))
                return
            }
            let email = authDataResult?.user.email ?? "No email"
            completionBlock(.success(.init(email: email)))
        }
    }
    
    func recoverPass(email: String, completionBlock: @escaping (Result<UserModel, Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                completionBlock(.failure(error))
                return
            }
            completionBlock(.success(.init(email: email)))
        }
    }
    
    func logout() throws {
        try Auth.auth().signOut()
    }
}

