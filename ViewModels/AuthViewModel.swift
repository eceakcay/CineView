//
//  AuthViewModel.swift
//  FilmIncelemeApp
//
//  Created by Ece Akcay on 8.05.2025.
//

import Foundation
import FirebaseAuth

@MainActor
class AuthViewModel: ObservableObject
{ @Published var isSignedIn: Bool = false

  init() {
      // Başlangıçta mevcut kullanıcıyı kontrol et
      if let user = Auth.auth().currentUser {
          isSignedIn = true
          print("Başlangıç: Kullanıcı oturum açık, uid: \(user.uid)")
      } else {
          isSignedIn = false
          print("Başlangıç: Kullanıcı oturum kapalı")
      }
      
      // Oturum değişikliklerini dinle
      Auth.auth().addStateDidChangeListener { _, user in
          self.isSignedIn = user != nil
          if let user = user {
              print("Oturum durumu değişti: Giriş yapıldı, uid: \(user.uid)")
          } else {
              print("Oturum durumu değişti: Çıkış yapıldı")
          }
      }
  }
  
  func signIn(email: String, password: String) async {
      do {
          try await Auth.auth().signIn(withEmail: email, password: password)
          print("Giriş başarılı")
      } catch {
          print("Giriş başarısız: \(error.localizedDescription)")
      }
  }
  
  func signUp(email: String, password: String) async {
      do {
          try await Auth.auth().createUser(withEmail: email, password: password)
          print("Kayıt başarılı")
      } catch {
          print("Kayıt başarısız: \(error.localizedDescription)")
      }
  }
  
  func signOut() async {
      do {
          try Auth.auth().signOut()
          print("Çıkış başarılı")
      } catch {
          print("Çıkış başarısız: \(error.localizedDescription)")
      }
  }

}
