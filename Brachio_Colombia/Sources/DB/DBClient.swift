//
//  DBClient.swift
//  Brachio_Colombia
//
//  Created by 神原良継 on 2021/03/15.
//

import Foundation
import Firebase
import FirebaseAuth
import RxSwift
import FirebaseFirestoreSwift

struct DBClient {
    static let shared = DBClient()
    private let db = Firestore.firestore()
    
    func singup(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult , error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let uid = authResult?.user.uid {
                db.document("users/\(uid)").setData(["groupIds": []])
            }
        }
        completion(.success(()))
    }
    
    func login(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            }
            else {
                completion(.success(()))
            }
        }
    }
    
    func joinGroup(groupId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let user = Auth.auth().currentUser else { return }
        
        let userReference: DocumentReference = db.document("users/\(user.uid)")
        userReference.updateData(["groupIds": FieldValue.arrayUnion([groupId])]) { error in
            if let error = error {
                completion(.failure(error))
            }
            else {
                completion(.success(()))
            }
        }
    }
    
    func createGroup(group: Group, completion: @escaping (Result<Void, Error>) -> Void) {
        // TODO: 要チェック
        guard let user = Auth.auth().currentUser else { return }

        let userReference: DocumentReference = db.document("users/\(user.uid)")
        let groupReference: DocumentReference = db.collection("groups").document()

        db.runTransaction({ (transaction, errorPointer) -> Any? in
            transaction.setData(group.dictionary, forDocument: groupReference)
            transaction.updateData(["groupIds": FieldValue.arrayUnion([groupReference.documentID])], forDocument: userReference)
            return nil
        }, completion: { (_, error)  in
            if let error = error {
                completion(.failure(error))
                return
            }
        })
        completion(.success(()))
    }
    
    
    func createProfile(groupId: String, profile: Profile, completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection("groups/\(groupId)/profiles").document().setData(profile.dictionary) { error in
            if let error = error {
                completion(.failure(error))
                return
            }
            else{
                completion(.success(()))
            }
        }
    }
    
    func getGroups(completion: @escaping (Result<[Group], Error>) -> Void){
       
        guard let user = Auth.auth().currentUser else { return }
        let userReference: DocumentReference = db.document("users/\(user.uid)")
        let groupsCollectionReference: CollectionReference = db.collection("groups")
        
        db.runTransaction({ (transaction, errorPointer) -> Any? in

            let document = try? transaction.getDocument(userReference)
            guard let data = document?.data(), let groupIds = data["groupIds"] as? [String] else {
                return nil
            }
            
            let groups = groupIds.compactMap { id -> Group? in
                let doc = groupsCollectionReference.document(id)
                if let snapshot = try? transaction.getDocument(doc), var group = try? snapshot.data(as: Group.self) {
                    group.id = doc.documentID
                    return group
                }
                else {
                    return nil
                }
            }
            completion(.success(groups))
            return nil
            
        }, completion: { (_, error)  in
            if let error = error {
                completion(.failure(error))
                return
            }
        })
    }
    
    func getProfiles(groupId: String, completion: @escaping (Result<[Profile], Error>) -> Void) {
        
        db.collection("groups/\(groupId)/profiles").getDocuments() { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let snapshot = snapshot {
                let profiles = snapshot.documents.compactMap {
                        try? $0.data(as: Profile.self)
                    }
                completion(.success(profiles))
            }
        }
    }
}
