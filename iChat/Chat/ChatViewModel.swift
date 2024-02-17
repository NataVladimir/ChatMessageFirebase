//
//  ChatViewModel.swift
//  iChat
//
//  Created by Tiago Aguiar on 16/08/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ChatViewModel: ObservableObject {
    
    @Published var messages: [Message] = [
        Message(uuid: UUID().uuidString, text: "dfaefaef", isMe: false)
       
    
    ]
    
    @Published var text = ""
    
    var inserting = false
    var newCount = 0
    let limit = 20
    
    private let repo: ChatRepository
    
    init(repo: ChatRepository) {
        self.repo = repo
    }
    
    func onAppear(contact: Contact) {
        repo.fetchChat(limit: limit, contact: contact, lastMessage: self.messages.last) { message in
            
            if self.inserting {
                self.messages.insert(message, at: 0)
            } else {
                self.messages.append(message)
            }
            
            self.inserting = false
            self.newCount = self.messages.count
        }
    }
    
    func sendMessage(contact: Contact) {
        let text = self.text.trimmingCharacters(in: .whitespacesAndNewlines)
        newCount = newCount + 1
        self.text = ""
        self.inserting = true
        
        repo.sendMessage(text: text, contact: contact)
    }
    
}
