//
//  iChatApp.swift
//  iChat
//
//  Created by Tiago Aguiar on 07/10/21.
//

import SwiftUI
import Firebase

@main
struct iChatApp: App {
  
  init() {
    FirebaseApp.configure()
  }
  
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
