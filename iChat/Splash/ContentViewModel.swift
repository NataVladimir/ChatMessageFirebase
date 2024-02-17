//
//  ContentViewModel.swift
//  iChat
//
//  Created by Tiago Aguiar on 11/02/22.
//

import Foundation
import FirebaseAuth

class ContentViewModel: ObservableObject {
  
  @Published var isLogged = Auth.auth().currentUser != nil
  
  func onAppear() {
    Auth.auth().addStateDidChangeListener { auth, user in
      self.isLogged = user != nil
    }
  }
  
}
