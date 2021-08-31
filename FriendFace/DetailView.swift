//
//  DetailView.swift
//  FriendFace
//
//  Created by Milo Wyner on 8/29/21.
//

import SwiftUI
import CoreData

struct DetailView: View {
    let user: UserEntity
    @FetchRequest(entity: UserEntity.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]) var users: FetchedResults<UserEntity>
    
    var body: some View {
        List {
            VStack(alignment: .leading, spacing: 16) {
                Detail(label: "Age: ", content: "\(user.age)")
                Detail(label: "Company: ", content: user.company ?? "")
                Detail(label: "Email: ", content: user.email ?? "")
                Detail(label: "Address: ", content: user.address ?? "")
                Detail(label: "About: ", content: user.about ?? "")
                Detail(label: "Registered: ", content: user.registeredFormatted)
                Text("Friends")
                    .font(.title.bold())
                    .padding(.top)
            }
            
            ForEach(user.friendArray) { friend in
                NavigationLink(
                    destination: DetailView(user: users.first(where: { $0.id == friend.id })!),
                    label: {
                        Text(friend.name ?? "")
                    })
            }
        }
        .padding(.top)
        .navigationBarTitle(user.name ?? "")
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
    @FetchRequest(entity: DetailView_Previews.entity, sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]) var users: FetchedResults<UserEntity>
    
    var body: some View {
        NavigationView {
            DetailView(user: users[0])
        }
        .onAppear(perform: {
            if users.isEmpty {
                UserEntity.downloadUsers()
            }
        })
    }
}

struct DetailView_Previews: PreviewProvider {
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static let entity = NSEntityDescription.entity(forEntityName: "UserEntity", in: context)!
    
    static var previews: some View {
        PreviewContainer().environment(\.managedObjectContext, context)
    }
}
