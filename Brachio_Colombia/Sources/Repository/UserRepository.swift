//
//  UserRepository.swift
//  Brachio_Colombia
//
//  Created by 化田晃平 on R 3/03/16.
//

import Foundation

struct UserRepository {
    private let dbClient = DBClient.shared
    
    func login(email: String, password: String, completion: @escaping (Result<Void,Error>) -> Void) {
        dbClient.login(email: email, password: password, completion: completion)
    }
    
    func signup(email: String, password: String, completion: @escaping (Result<Void,Error>) -> Void) {
        dbClient.singup(email: email, password: password, completion: completion)
    }
}
