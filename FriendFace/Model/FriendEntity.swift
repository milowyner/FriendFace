//
//  FriendEntity.swift
//  FriendFace
//
//  Created by Milo Wyner on 8/30/21.
//

import CoreData

class FriendEntity: NSManagedObject, Decodable {
    enum CodingKeys: CodingKey {
        case id, name
    }
        
    required convenience init(from decoder: Decoder) throws {
        self.init(context: UserEntity.context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
}
