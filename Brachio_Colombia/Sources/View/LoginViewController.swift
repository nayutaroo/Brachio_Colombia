//
//  LoginViewController.swift
//  Brachio_Colombia
//
//  Created by 神原良継 on 2021/03/16.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.isSecureTextEntry = true
        }
    }
    @IBOutlet weak var forcornerButton: UIButton! {
        didSet {
            forcornerButton.cornerRadius = 25
            forcornerButton.shadowOffset = CGSize(width: 3, height: 3)
            forcornerButton.shadowColor = .black
            forcornerButton.shadowOpacity = 0.6
        }
        
    }
    
    //記入されたメールアドレス，パスワードを格納する変数
    var mailAddress: String = ""
    var passWord: String = ""
    
    private let userRepository = UserRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addBackground(name: "tree")
        title = "Sign In"
        forcornerButton.layer.cornerRadius = 15.0

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func loginButton(_ sender: Any) {
        mailAddress = mailTextField.text!
        passWord = passwordTextField.text!
        
        userRepository.login(email: mailAddress, password: passWord) { [weak self] result in
            switch result {
            case .success():
                //画面遷移する
                let groupListVC = GroupListViewController()
                self?.navigationController?.pushViewController(groupListVC, animated: true)
            case .failure(let error):
                print(error)
            }
        }
        
        
    }
    @IBAction func signupButton(_ sender: Any) {
        //画面遷移→SignupViewController
        let signupVC = SignupViewController()
        navigationController?.pushViewController(signupVC, animated: true)
    }
    
}
