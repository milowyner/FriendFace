//
//  Users.swift
//  FriendFace
//
//  Created by Milo Wyner on 8/29/21.
//

import Foundation

class Users {
    var list = [User]()
    
    init() {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            guard let data = data else {
                print("Error fetching data. \(error?.localizedDescription ?? "Unkown error.")")
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                self.list = try decoder.decode([User].self, from: data)
            } catch {
                print("Error decoding data. \(error.localizedDescription)")
            }
        }.resume()
    }
}
