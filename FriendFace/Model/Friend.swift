//
//  Friend.swift
//  FriendFace
//
//  Created by Milo Wyner on 8/29/21.
//

import Foundation

struct Friend: Identifiable, Decodable {
    let id: UUID
    let name: String
}
