//
//  Group.swift
//  Brachio_Colombia
//
//  Created by 化田晃平 on R 3/03/15.
//

import Foundation

struct Group {
    let name: String
    let imageUrl: String
    
    var dictionary: [String: Any] {
        return ["name": name,
                "imageUrl": imageUrl]
    }
}
