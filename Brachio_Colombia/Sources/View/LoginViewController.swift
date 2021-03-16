//
//  LoginViewController.swift
//  Brachio_Colombia
//
//  Created by 神原良継 on 2021/03/16.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forcornerButton: UIButton!
    
    //記入されたメールアドレス，パスワードを格納する変数
    var mailAddress: String = ""
    var passWord: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        forcornerButton.layer.cornerRadius = 15.0

    }
    @IBAction func loginButton(_ sender: Any) {
        mailAddress = mailTextField.text!
        passWord = passwordTextField.text!
    }
    @IBAction func signupButton(_ sender: Any) {
        //画面遷移→SignupViewController
    }
    
}
