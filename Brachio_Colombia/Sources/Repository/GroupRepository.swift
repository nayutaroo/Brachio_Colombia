//
//  GroupRepository.swift
//  Brachio_Colombia
//
//  Created by 化田晃平 on R 3/03/15.
//

import Foundation
 
struct GroupRepository {
    
    internal let dbClient = DBClient.shared
    func fetch(completion: @escaping (Result<[Group],Error>) -> Void) {
        dbClient.getGroups(completion: completion)
    }
    
    func create(group: Group, completion: @escaping (Result<Void,Error>) -> Void) {
        dbClient.createGroup(group: group, completion: completion)
    }
}
