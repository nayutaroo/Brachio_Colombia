//
//  GroupRepository.swift
//  Brachio_Colombia
//
//  Created by 化田晃平 on R 3/03/15.
//

import Foundation

struct GroupRepository {
    private let dbClient = DBClient.shared
    
//    create() ->

//    func fetchFavoriteWorks() -> [Work] {
//        dbClient.select()
//            .map(Work.init(realm:))
//    }
//
//    func favorite(work: Work) -> Result<Work, DBError> {
//        dbClient.create(object: RealmWork(work: work))
//            .map(Work.init(realm:))
//    }
//
//    func unFavorite(workId: Int) -> Result<Void, DBError> {
//        let item: Result<RealmWork, DBError> = dbClient.item(id: workId)
//        return item
//            .flatMap(dbClient.delete(object:))
//            .map { _ in }
//    }
}
