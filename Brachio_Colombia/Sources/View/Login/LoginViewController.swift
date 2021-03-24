//
//  LoginViewController.swift
//  Brachio_Colombia
//
//  Created by 神原良継 on 2021/03/16.
//

import UIKit

final class LoginViewController: UIViewController {

    @IBOutlet private weak var mailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.isSecureTextEntry = true
        }
    }
    @IBOutlet private weak var forcornerButton: UIButton! {
        didSet {
            forcornerButton.cornerRadius = 25
            forcornerButton.shadowOffset = CGSize(width: 3, height: 3)
            forcornerButton.shadowColor = .black
            forcornerButton.shadowOpacity = 0.6
        }
    }
    
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
    
    @IBAction private func loginButton(_ sender: Any) {
        guard let mailAddress = mailTextField.text else {
            showErrorMessageAlert(with: "メールアドレスを入力してください")
            return
        }
        guard let passWord = passwordTextField.text else {
            showErrorMessageAlert(with: "パスワードを入力してください")
            return
        }
        
        userRepository.login(email: mailAddress, password: passWord) { [weak self] result in
            guard let me = self else { return }
            switch result {
            case .success():
                let groupListVC = GroupListViewController()
                me.navigationController?.pushViewController(groupListVC, animated: true)
            case .failure(let error):
                me.showErrorAlert(with: error)
            }
        }
    }
    
    @IBAction private func signupButton(_ sender: Any) {
        //画面遷移→SignupViewController
        let signupVC = SignupViewController()
        navigationController?.pushViewController(signupVC, animated: true)
    }
    
}
