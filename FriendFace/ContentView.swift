//
//  ContentView.swift
//  FriendFace
//
//  Created by Milo Wyner on 8/29/21.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    
    var body: some View {
        List(users) { user in
            Text(user.name)
            Text("\(user.age)")
            Text(user.company)
        }
        .onAppear(perform: loadUsers)
    }
    
    func loadUsers() {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("Error fetching data. \(error?.localizedDescription ?? "Unkown error.")")
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                users = try decoder.decode([User].self, from: data)
            } catch {
                print("Error decoding data. \(error.localizedDescription)")
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
