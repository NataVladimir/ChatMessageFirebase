//
//  SignUpViewModel.swift
//  iChat
//
//  Created by Tiago Aguiar on 07/10/21.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class SignUpViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    
    @Published var image = UIImage()
    
    @Published var formInvalid = false
    var alertText = ""
    
    @Published var isLoading = false
    
    private let repo: SignUpRepository
    
    init(repo: SignUpRepository) {
        self.repo = repo
    }
    
    func signUp() {
        print("nome: \(name), email: \(email), senha: \(password)")
        
        if (image.size.width <= 0) {
            formInvalid = true
            alertText = "Selecione uma foto"
            return
        }
        
        isLoading = true
        
        repo.signUp(withEmail: email, password: password, image: image, name: name) { err in
            if let err = err {
                self.formInvalid = true
                self.alertText = err
                print(err)
            }
            self.isLoading = false
        }
        

    }
    
}
