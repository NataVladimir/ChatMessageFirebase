//
//  ContactsViewModel.swift
//  iChat
//
//  Created by Tiago Aguiar on 07/03/22.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

class ContactViewModel: ObservableObject {
    
    @Published var contacts: [Contact] = []
    @Published var isLoading = false
    
    var isLoaded = false
    
    private let repo: ContactRepository
    
    init(repo: ContactRepository) {
        self.repo = repo
    }
    
    func getContacts() {
        if isLoaded { return }
        isLoading = true
        isLoaded = true
        
        repo.getContacts { contacts in
            self.contacts.append(contentsOf: contacts)
            self.isLoading = false
        }
    }
    
}
