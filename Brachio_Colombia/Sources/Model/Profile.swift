//
//  Profile.swift
//  Brachio_Colombia
//
//  Created by 化田晃平 on R 3/03/16.
//

import Foundation

struct Profile: Decodable {
    let name: String
    let message: String
    let imageUrl: String
    
    var dictionary: [String: Any] {
        return ["name": name,
                "message": message,
                "imageUrl": imageUrl]
    }
    
    
}
