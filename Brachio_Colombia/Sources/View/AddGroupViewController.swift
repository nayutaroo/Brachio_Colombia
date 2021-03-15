//
//  AddGroupViewController.swift
//  Brachio_Colombia
//
//  Created by 化田晃平 on R 3/03/15.
//

import UIKit
import RxSwift
import RxCocoa

final class AddGroupViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var groupNameTextField: UITextField! {
        didSet {
            groupNameTextField.placeholder = "グループ名を入力"
        }
    }
    @IBOutlet weak var addGroupButton: UIButton! {
        didSet {
            addGroupButton.setTitle("グループを追加", for: .normal)
        }
    }
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupNameTextField.rx.controlEvent(.editingDidEndOnExit).asDriver()
            .drive(onNext: { _ in
                self.groupNameTextField.resignFirstResponder()
            })
            .disposed(by: disposeBag)
        
        addGroupButton.rx.tap.subscribe { _ in
            // TODO: グループを追加するpostの処理
            print("hoge")
        }
        .disposed(by: disposeBag)
    }
}
