//
//  MessagesView.swift
//  iChat
//
//  Created by Tiago Aguiar on 11/02/22.
//

import SwiftUI

struct MessageView: View {
  
  @StateObject var viewModel = MessageViewModel(repo: MessageRepository())
  
    var body: some View {
      NavigationView {
        VStack {
            
            List(viewModel.contacts, id: \.self) { contact in
                NavigationLink {
                    ChatView(contact: contact)
                } label: {
                    ContactMessageRow(contact: contact)
                }

            }
        }
        .onAppear {
            viewModel.handleEnabled(enabled: true)
            viewModel.getContacts()
        }
        .onDisappear {
            viewModel.handleEnabled(enabled: false)
        }
        .navigationTitle("Mensagens")
        .toolbar {
          ToolbarItem(id: "contacts",
                      placement: ToolbarItemPlacement.navigationBarTrailing,
                      showsByDefault: true) {
            NavigationLink("Contatos", destination: ContactView())
          }
          ToolbarItem(id: "logout",
                      placement: ToolbarItemPlacement.navigationBarTrailing,
                      showsByDefault: true) {
            Button("Logout") {
              viewModel.logout()
            }
          }
        }
      }
    }
}

struct ContactMessageRow: View {
    
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
            
            VStack (alignment: .leading) {
                Text(contact.name)
                if let msg = contact.lastMessage {
                    Text(msg)
                        .lineLimit(1)
                }
            }
            Spacer()
        }
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
