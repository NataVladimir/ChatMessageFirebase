//
//  ChatRepository.swift
//  iChat
//
//  Created by Tiago Aguiar on 18/08/22.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class ChatRepository {
    
    var myName = ""
    var myPhoto = ""
    
    
    func fetchChat(limit: Int, contact: Contact, lastMessage: Message?, completion: @escaping (Message) -> Void) {
        let fromId = Auth.auth().currentUser!.uid
        
        Firestore.firestore().collection("users")
            .document(fromId)
            .getDocument { snapshot, error in
                if let error = error {
                    print("ERROR: fetching documents \(error)")
                    return
                }
                
                if let document = snapshot?.data() {
                    self.myName = document["name"] as! String
                    self.myPhoto = document["profileUrl"] as! String
                }
            }
        
        Firestore.firestore().collection("conversations")
            .document(fromId)
            .collection(contact.uuid)
            .order(by: "timestamp", descending: true)
            .limit(to: limit)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("ERROR: fetching documents \(error)")
                    return
                }
                
                if let changes = querySnapshot?.documentChanges {
                    for doc in changes {
                        if doc.type == .added {
                            let document = doc.document
                            print("Document is :\(document.documentID) \(document.data())")
                            
                            let message = Message(uuid: document.documentID,
                                                  text: document.data()["text"] as! String,
                                                  isMe: fromId == document.data()["fromId"] as! String)
                                                  
                            
                            completion(message)
                        }
                    }
                    print("----------")
                }
            }
    }
    
    func sendMessage(text: String, contact: Contact) {
        let fromId = Auth.auth().currentUser!.uid
        let timestamp = Date().timeIntervalSince1970
        
        Firestore.firestore().collection("conversations")
            .document(fromId)
            .collection(contact.uuid)
            .addDocument(data: [
                "text": text,
                "fromId": fromId,
                "toId": contact.uuid,
                "timestamp": UInt(timestamp)
            ]) { err in
                if err != nil {
                    print("ERROR: \(err!.localizedDescription)")
                    return
                }
                
                Firestore.firestore().collection("last-messages")
                    .document(fromId)
                    .collection("contacts")
                    .document(contact.uuid)
                    .setData([
                        "uid": contact.uuid,
                        "username": contact.name,
                        "photoUrl": contact.profileUrl,
                        "timestamp": UInt(timestamp),
                        "lastMessage": text
                    ])
            }
        
        
        Firestore.firestore().collection("conversations")
            .document(contact.uuid)
            .collection(fromId)
            .addDocument(data: [
                "text": text,
                "fromId": fromId,
                "toId": contact.uuid,
                "timestamp": UInt(timestamp)
            ]) { err in
                if err != nil {
                    print("ERROR: \(err!.localizedDescription)")
                    return
                }
                
                Firestore.firestore().collection("last-messages")
                    .document(contact.uuid)
                    .collection("contacts")
                    .document(fromId)
                    .setData([
                        "uid": fromId,
                        "username": self.myName,
                        "photoUrl": self.myPhoto,
                        "timestamp": UInt(timestamp),
                        "lastMessage": text
                    ])
            }
    }
    
}
