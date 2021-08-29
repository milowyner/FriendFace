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
                    destination: DetailView(user: user),
                    label: {
                        Text(user.name)
                        Text("\(user.age)")
                        Text(user.company)
                    })
            }
            .onAppear {
                User.loadUsers { users = $0 }
            }
            .navigationBarTitle(Text("FriendFace"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
