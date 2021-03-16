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
    
    private let userRepository = UserRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forcornerButton.layer.cornerRadius = 15.0

    }
    @IBAction func loginButton(_ sender: Any) {
        mailAddress = mailTextField.text!
        passWord = passwordTextField.text!
        
        userRepository.login(email: mailAddress, password: passWord) { (result) in
            switch result {
            case .success():
                break
            case .failure(let error):
                print(error)
            }
        }
        //画面遷移する
        let groupListVC = GroupListViewController()
        navigationController?.pushViewController(groupListVC, animated: true)
        
    }
    @IBAction func signupButton(_ sender: Any) {
        //画面遷移→SignupViewController
        let signupVC = SignupViewController()
        navigationController?.pushViewController(signupVC, animated: true)
    }
    
}
