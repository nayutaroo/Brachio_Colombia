//
//  AddProfileViewController.swift
//  Brachio_Colombia
//
//  Created by 山根大生 on 2021/03/15.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage

class AddProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //let storage = Storage.storage()
    //ライブラリから取得した画像をボタンに貼り付けるために@IBOutletで宣言
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    
    var name: String!
    var message: String!
    var selectedImage: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func addPhotoButton(_ sender: Any) {
        //ライブラリにアクセス
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            
            picker.allowsEditing = true
            present(picker, animated: true, completion: nil)
        }
        
        //取得したライブラリの写真をimageButtonにぶちこむ
        
    }
    
    @IBAction func addProfile(_ sender: Any) {
        name = nameTextField.text ?? ""
        message = messageTextView.text ?? ""
        //firestoreにPOSTする
        saveToFireStore()
        //POST完了したら、画面を閉じる
        dismiss(animated: true, completion: nil)
    }
    
    //表示するためのメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageButton.setImage(info[.editedImage] as? UIImage, for: .normal)
        selectedImage = info[.editedImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    
    //firestorageに画像をアップロードするためのメソッド
    fileprivate func upload(completed: @escaping(_ url: String?) -> Void) {
        let date = Date()
        let currentTimeStampInSecond = UInt64(floor(date.timeIntervalSince1970 * 1000))
        let storageRef = Storage.storage().reference().child("images").child("\(currentTimeStampInSecond).jpg")
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        if let uploadData = self.selectedImage.jpegData(compressionQuality: 0.9) {
            storageRef.putData(uploadData, metadata: metaData) { (metadata, error) in
                if error != nil {
                    completed(nil)
                    print("error: \(error?.localizedDescription)")
                }
                storageRef.downloadURL(completion: {(url, error) in
                    if error != nil {
                        completed(nil)
                        print("error:\(error?.localizedDescription)")
                    }
                    print("url: \(url?.absoluteString)")
                    completed(url?.absoluteString)
                })
            }
        }
        
    }
    
    //Firestoreにurlを保存するメソッド
    //以下はダミーコードのため、なゆたが作ってくれたモデルに合わせて書き換えなければならない
    fileprivate func saveToFireStore() {
        var data: [String: Any] = [:]
        upload(){url in
            guard let url = url else { return }
            data["image"] = url
            Firestore.firestore().collection("images").document().setData(data) { error in
                if error != nil {
                    print("error: \(error?.localizedDescription)")
                }
                print("image saved!")
            }
        }
    }
    
}
