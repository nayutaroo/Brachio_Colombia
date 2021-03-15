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

struct DBClient {
    static let shared = DBClient()
    private let db = Firestore.firestore()
    
    func singup(email: String, password: String, completion: @escaping (Result<Void, DBError>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult , error in
            if let error = error {
                completion(.failure(.unknown(error)))
            }
            else {
                completion(.success(()))
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Result<Void, DBError>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(.unknown(error)))
            }
            else {
                completion(.success(()))
            }
        }
    }
    
    func create(group: Group, completion: @escaping (Result<Void, DBError>) -> Void) {
        
        // TODO: 要チェック
        guard let user = Auth.auth().currentUser else { return }

        let userReference: DocumentReference = db.document("users/\(user.uid)")
        let groupReference: DocumentReference = db.collection("groups").document()

        db.runTransaction({ (transaction, errorPointer) -> Any? in
            transaction.setData(group.dictionary, forDocument: groupReference)
            transaction.updateData(["groups": FieldValue.arrayUnion([groupReference.documentID])], forDocument: userReference)
            return nil
        }, completion: { (_, error)  in
            if let error = error {
                completion(.failure(.unknown(error)))
                return
            }
        })
        completion(.success(()))
    }
    
//    func login(email: String, password: String) -> Single<Void> {
//        Single<Void>.create { single in
//            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
//                 if let error = error {
//                    single(.failure(error))
//                 }
//                 else {
//                    single(.success(Auth.auth().currentUser))
//                 }
//             }
//        }
//        return Disposables.create()
//    }


//    func createGroup(group: Group, completion: @escaping (Result<Group, DBError>) -> Void) {
//        var ref: DocumentReference? = nil


//
//        ref = db.collection("groups").addDocument(data: group.dictionary) { err in
//            if let err = err {
//                completion(.failure(.unknown(err)))
//                return
//            } else {
//                print("Document added with ID: \(ref!.documentID)")
//                completion(.success(group))
//            }
//        }
//    }
    
//    /// DB にオブジェクトを作成。
//    /// - Parameter object: 作成するオブジェクト
//    /// - Returns: Result
//    func create>(object: T) -> Result<T, DBError> {
//        do {
//            try realm.write {
//                // Workaround: .error を指定したかったが、すでに primary_key が存在する場合
//                // `logic_error` がスローされてしまっており、ランタイムのエラーじゃないので捕捉できない
//                realm.add(object, update: .modified)
//            }
//            return .success(object)
//        } catch let e {
//            return .failure(.unknown(e))
//        }
//    }
//
//    /// DB からオブジェクトを削除。
//    /// - Parameter object: 削除するオブジェクト
//    /// - Returns: Result
//    func delete<T: Object>(object: T) -> Result<T, DBError> {
//        do {
//            try realm.write {
//                realm.delete(object)
//            }
//            return .success(object)
//        } catch let e {
//            return .failure(.unknown(e))
//        }
//    }
//
//    /// DB からオブジェクトを取得
//    /// - Returns:
//    func select<T: Object>(condition: String = "") -> [T] {
//        let objects = realm.objects(T.self)
//        if condition.isEmpty {
//            return Array(objects)
//        }
//        return Array(objects.filter(condition))
//    }
//
    
//
//    var ref: DocumentReference? = nil
//    var ref = db.collection("users").addDocument(data: [
//        "first": "Ada",
//        "last": "Lovelace",
//        "born": 1815
//    ]) { err in
//        if let err = err {
//            print("Error adding document: \(err)")
//        } else {
//            print("Document added with ID: \(ref!.documentID)")
//        }
//    }
//
    
}
