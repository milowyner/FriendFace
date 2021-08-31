//
//  UserEntity.swift
//  FriendFace
//
//  Created by Milo Wyner on 8/30/21.
//

import UIKit
import CoreData

class UserEntity: NSManagedObject, Decodable {
    enum CodingKeys: CodingKey {
        case id, name, age, company, email, address, about, registered
    }
    
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    required convenience init(from decoder: Decoder) throws {
        self.init(context: Self.context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.age = try container.decode(Int16.self, forKey: .age)
        self.company = try container.decode(String.self, forKey: .company)
        self.email = try container.decode(String.self, forKey: .email)
        self.address = try container.decode(String.self, forKey: .address)
        self.about = try container.decode(String.self, forKey: .about)
        self.registered = try container.decode(Date.self, forKey: .registered)
    }
    
    var registeredFormatted: String {
        guard let registered = registered else { return "" }
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: registered)
    }
    
    static func downloadUsers() {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("Error fetching data. \(error?.localizedDescription ?? "Unkown error.")")
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            DispatchQueue.main.async {
                do {
                    _ = try decoder.decode([UserEntity].self, from: data)
                    if self.context.hasChanges {
                        try? self.context.save()
                    }
                } catch {
                    print("Error decoding data. \(error.localizedDescription)")
                }
            }
            
        }.resume()
    }
}
