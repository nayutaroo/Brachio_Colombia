//
//  SignupViewController.swift
//  Brachio_Colombia
//
//  Created by 神原良継 on 2021/03/16.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var signupMailTextField: UITextField!
    @IBOutlet weak var signupPassTextField: UITextField! {
        didSet {
            signupPassTextField.isSecureTextEntry = true
        }
    }
    
    var signupMailAddress: String = ""
    var signupPassWord: String = ""
    
    private let userRepository = UserRepository()
    
    @IBOutlet weak var forCornerButton: UIButton! {
        didSet {
            forCornerButton.cornerRadius = 25
            forCornerButton.shadowOffset = CGSize(width: 3, height: 3)
            forCornerButton.shadowColor = .black
            forCornerButton.shadowOpacity = 0.6
        }
    }
    
    override func viewDidLoad() {
        view.addBackground(name: "tree")
        title = "Sign Up"
        super.viewDidLoad()

        forCornerButton.layer.cornerRadius = 15.0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }


    @IBAction func signupButton(_ sender: Any) {
        signupMailAddress = signupMailTextField.text!
        signupPassWord = signupPassTextField.text!
        
        userRepository.signup(email: signupMailAddress, password: signupPassWord) { [weak self] result in
            guard let me = self else { return }
            switch result {
            case .success():
                let groupListVC = GroupListViewController()
                self?.navigationController?.pushViewController(groupListVC, animated: true)
            case .failure(let error):
                me.showErrorAlert(with: error)
            }
        }
        
    }
    
    @IBAction func toLoginButton(_ sender: Any) {
        //ログインボタンへの画面遷移
        self.navigationController?.popViewController(animated: true)
    }
}
