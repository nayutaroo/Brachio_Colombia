//
//  SignupViewController.swift
//  Brachio_Colombia
//
//  Created by 神原良継 on 2021/03/16.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var signupMailTextField: UITextField!
    @IBOutlet weak var signupPassTextField: UITextField!
    
    @IBOutlet weak var forCornerButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        forCornerButton.layer.cornerRadius = 15.0
    }


    @IBAction func signupButton(_ sender: Any) {
        
    }
    @IBAction func toLoginButton(_ sender: Any) {
        //ログインボタンへの画面遷移
    }
}
