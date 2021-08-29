//
//  DetailView.swift
//  FriendFace
//
//  Created by Milo Wyner on 8/29/21.
//

import SwiftUI

struct DetailView: View {
    let user: User
    
    var body: some View {
        VStack {
            Text(user.name)
            Text("\(user.age)")
            Text(user.company)
            Text(user.address)
        }
    }
}

fileprivate struct PreviewContainer: View {
    @State private var user: User?
    
    var body: some View {
        Group {
            if let user = user {
                DetailView(user: user)
            } else {
                Text("Run the live preview")
            }
        }
        .onAppear {
            User.loadUsers { user = $0[0] }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContainer()
    }
}
