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
    let friends: [Friend]
    
    var registeredFormatted: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: registered)
    }
}

extension User {
    static func loadUsers(completion: @escaping ([User]) -> ()) {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("Error fetching data. \(error?.localizedDescription ?? "Unkown error.")")
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                completion(try decoder.decode([User].self, from: data))
            } catch {
                print("Error decoding data. \(error.localizedDescription)")
            }
        }.resume()
    }
}
