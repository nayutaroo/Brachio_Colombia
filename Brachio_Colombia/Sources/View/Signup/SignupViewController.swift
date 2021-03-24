//
//  SignupViewController.swift
//  Brachio_Colombia
//
//  Created by 神原良継 on 2021/03/16.
//

import UIKit

final class SignupViewController: UIViewController {

    @IBOutlet private weak var signupMailTextField: UITextField!
    @IBOutlet private weak var signupPassTextField: UITextField! {
        didSet {
            signupPassTextField.isSecureTextEntry = true
        }
    }
    
    private let userRepository = UserRepository()
    
    @IBOutlet private weak var forCornerButton: UIButton! {
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


    @IBAction private func signupButton(_ sender: Any) {
        guard let mailAddress = signupMailTextField.text else {
            showErrorMessageAlert(with: "メールアドレスを入力してください")
            return
        }
        guard let password = signupPassTextField.text else {
            showErrorMessageAlert(with: "パスワードを入力してください")
            return
        }
        
        userRepository.signup(email: mailAddress, password: password) { [weak self] result in
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
    
    @IBAction private func toLoginButton(_ sender: Any) {
        //ログインボタンへの画面遷移
        self.navigationController?.popViewController(animated: true)
    }
}
