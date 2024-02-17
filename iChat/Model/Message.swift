//
//  Message.swift
//  iChat
//
//  Created by Tiago Aguiar on 16/08/22.
//

import Foundation


struct Message: Hashable {
    let uuid: String
    let text: String
    let isMe: Bool
    
}
