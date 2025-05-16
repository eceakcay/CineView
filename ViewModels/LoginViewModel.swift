//
//  LoginViewModel.swift
//  FilmIncelemeApp
//
//  Created by Ece Akcay on 6.05.2025.
//

import Foundation
import FirebaseAuth

@MainActor
class LoginViewModel: ObservableObject {
    @Published var isSignedIn = false
    @Published var error: String?
    
    func signIn(email: String, password: String) async {
        do {
            _ = try await Auth.auth().signIn(withEmail: email, password: password)
            isSignedIn = true // nil kontrolü kaldırıldı
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    func signUp(email: String, password: String) async {
        do {
            _ = try await Auth.auth().createUser(withEmail: email, password: password)
            isSignedIn = true // nil kontrolü kaldırıldı
        } catch {
            self.error = error.localizedDescription
        }
    }
}

