//
//  User.swift
//  FriendFace
//
//  Created by Milo Wyner on 8/29/21.
//

import Foundation

struct User: Identifiable, Decodable {
    let id: UUID
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
}
