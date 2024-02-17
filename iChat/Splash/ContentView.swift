//
//  ContentView.swift
//  iChat
//
//  Created by Tiago Aguiar on 11/02/22.
//

import SwiftUI

struct ContentView: View {
  
  @StateObject var viewModel = ContentViewModel()
  
  var body: some View {
    ZStack {
      if viewModel.isLogged {
        MessageView()
      } else {
        SignInView()
      }
    }.onAppear {
      viewModel.onAppear()
    }
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
