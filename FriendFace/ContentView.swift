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
        NavigationView {
            List(users) { user in
                NavigationLink(
                    destination: DetailView(user: user, users: users),
                    label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(user.name)
                                HStack {
                                    Text("\(user.age) years old, works at \(user.company)")
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    })
            }
            .onAppear {
                User.loadUsers { users = $0 }
            }
            .navigationBarTitle("FriendFace")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
