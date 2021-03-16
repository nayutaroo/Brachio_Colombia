//
//  AddProfileViewController.swift
//  Brachio_Colombia
//
//  Created by 山根大生 on 2021/03/15.
//

import UIKit

class AddProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //ライブラリから取得した画像をボタンに貼り付けるために@IBOutletで宣言
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    
    var name: String!
    var message: String!
    
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
        
        
        //POST完了したら、画面を閉じる
        dismiss(animated: true, completion: nil)
    }
    
    //表示するためのメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageButton.setImage(info[.editedImage] as? UIImage, for: .normal)
        dismiss(animated: true, completion: nil)
    }
}
