//
//  User.swift
//  FriendFace
//
//  Created by Milo Wyner on 8/29/21.
//

import Foundation

struct User: Identifiable, Decodable {
    var id = UUID()
    let name: String
    let age: Int
    let company: String
}
