//
//  ProfileRepository.swift
//  Brachio_Colombia
//
//  Created by 化田晃平 on R 3/03/15.
//

import Foundation

struct ProfileRepository {
    private let dbClient = DBClient.shared
    
    func fetch(groupId: String, completion: @escaping (Result<[Profile],Error>) -> Void) {
        dbClient.getProfiles(groupId: groupId, completion: completion)
    }
    
    func create(groupId: String, profile: Profile, completion: @escaping (Result<Void,Error>) -> Void) {
        dbClient.createProfile(groupId: groupId, profile: profile, completion: completion)
    }
}
