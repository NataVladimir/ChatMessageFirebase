//
//  ContactsView.swift
//  iChat
//
//  Created by Tiago Aguiar on 07/03/22.
//

import SwiftUI

struct ContactView: View {
  
  @StateObject var viewModel = ContactViewModel(repo: ContactRepository())
  
  var body: some View {
    VStack {
        
        List(viewModel.contacts, id: \.self) { contact in
            NavigationLink {
                ChatView(contact: contact)
            } label: {
                ContactRow(contact: contact)
            }
        }
    }.onAppear {
      viewModel.getContacts()
    }
    .navigationTitle("Contatos")
  }
}

struct ContactRow: View {
  
  var contact: Contact
  
  var body: some View {
    HStack {
      AsyncImage(url: URL(string: contact.profileUrl)) { image in
        image.resizable()
          .scaledToFit()
      } placeholder: {
        ProgressView()
      }
      .frame(width: 50, height: 50)
      
      Text(contact.name)
    }
  }
}

struct ContactsView_Previews: PreviewProvider {
  static var previews: some View {
    ContactView()
  }
}
