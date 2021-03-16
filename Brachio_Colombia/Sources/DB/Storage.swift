//
//  Storage.swift
//  Brachio_Colombia
//
//  Created by 化田晃平 on R 3/03/16.
//

import Foundation
import Firebase
import FirebaseFirestore


class DBStorage {
    static let shared = DBStorage()
    
    func uploadImage(image: UIImage, completion: @escaping (Result<String,Error>) -> Void) {
        let date = Date()
        let currentTimeStampInSecond = UInt64(floor(date.timeIntervalSince1970 * 1000))
        let storageRef = Storage.storage().reference().child("images").child("\(currentTimeStampInSecond).jpg")
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        if let uploadData = image.jpegData(compressionQuality: 0.9) {
            storageRef.putData(uploadData, metadata: metaData) { metadata, error in
                if let error = error {
                    completion(.failure(error))
                }
                storageRef.downloadURL(completion: { url, error in
                    if let error = error {
                        completion(.failure(error))
                    }
                    if let url = url {
                        completion(.success(url.absoluteString))
                    }
                })
            }
        }
    }
}
