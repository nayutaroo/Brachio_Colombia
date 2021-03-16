//
//  Group.swift
//  Brachio_Colombia
//
//  Created by 化田晃平 on R 3/03/15.
//

import Foundation

struct Group: Decodable {
    let name: String
    let imageUrl: String
    let profiles: [Profile]
    
    var dictionary: [String: Any] {
        return ["name": name,
                "imageUrl": imageUrl,
                "profiles": profiles
        ]
    }
    
    init(name: String, imageUrl: String, profiles: [Profile] = []) {
        self.name = name
        self.imageUrl = imageUrl
        self.profiles = profiles
    }
}
