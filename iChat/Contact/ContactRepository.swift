//
//  ContactRepository.swift
//  iChat
//
//  Created by Tiago Aguiar on 18/08/22.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class ContactRepository {
    
    func getContacts(completion: @escaping ([Contact]) -> Void) {
        var contacts: [Contact] = []
        Firestore.firestore().collection("users")
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("Erro ao buscar contatos: \(error)")
                    return
                }
                
                for document in querySnapshot!.documents {
                    if Auth.auth().currentUser?.uid != document.documentID {
                        print("ID \(document.documentID) \(document.data())")
                        contacts.append(Contact(uuid: document.documentID,
                                                name: document.data()["name"] as! String,
                                                profileUrl: document.data()["profileUrl"] as! String))
                    }
                }
                
                completion(contacts)
            }
    }
}
