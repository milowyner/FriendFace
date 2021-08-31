//
//  ContentView.swift
//  FriendFace
//
//  Created by Milo Wyner on 8/29/21.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: UserEntity.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]) var users: FetchedResults<UserEntity>
    
    var body: some View {
        NavigationView {
            List(users) { user in
                NavigationLink(
                    destination: DetailView(user: user),
                    label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(user.name ?? "")
                                HStack {
                                    Text("\(user.age) years old, works at \(user.company ?? "")")
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    })
            }
            .navigationBarTitle("FriendFace")
            .onAppear(perform: {
                if users.isEmpty {
                    print("Empty! Fetching from internet.")
                    UserEntity.downloadUsers()
                }
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
