//
//  AddProfileViewController.swift
//  Brachio_Colombia
//
//  Created by 山根大生 on 2021/03/15.
//

import UIKit

class AddProfileViewController: UIViewController {

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
        
        //取得したライブラリの写真をimageButtonにぶちこむ
        
    }
    
   

    @IBAction func addProfile(_ sender: Any) {
        name = nameTextField.text ?? ""
        message = messageTextView.text ?? ""
        //firestoreにPOSTする
    }
}
