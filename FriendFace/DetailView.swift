//
//  DetailView.swift
//  FriendFace
//
//  Created by Milo Wyner on 8/29/21.
//

import SwiftUI

struct DetailView: View {
    let user: User
    let users: Users
    
    var body: some View {
        List {
            VStack(alignment: .leading, spacing: 16) {
                Detail(label: "Age: ", content: "\(user.age)")
                Detail(label: "Company: ", content: user.company)
                Detail(label: "Email: ", content: user.email)
                Detail(label: "Address: ", content: user.address)
                Detail(label: "About: ", content: user.about)
                Detail(label: "Registered: ", content: user.registeredFormatted)
                Text("Friends")
                    .font(.title.bold())
                    .padding(.top)
            }
            
            ForEach(user.friends) { friend in
                NavigationLink(
                    destination: DetailView(user: users.list.first(where: { $0.id == friend.id})!, users: users),
                    label: {
                        Text(friend.name)
                    })
            }
        }
        .padding(.top)
        .navigationBarTitle(user.name)
    }
    
    struct Detail: View {
        let label: String
        let content: String
        
        var body: some View {
            HStack(alignment: .top, spacing: 0) {
                Text(label)
                    .font(.headline)
                Text(content)
            }
        }
    }
}

fileprivate struct PreviewContainer: View {
    @State private var user: User?
    @State private var users = Users()
    
    var body: some View {
        NavigationView {
            if let user = user {
                DetailView(user: user, users: users)
            } else {
                Text("Run the live preview")
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContainer()
    }
}
