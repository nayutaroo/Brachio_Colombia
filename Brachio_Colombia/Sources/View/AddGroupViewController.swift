//
//  AddGroupViewController.swift
//  Brachio_Colombia
//
//  Created by 化田晃平 on R 3/03/15.
//

import UIKit
import RxSwift
import RxCocoa

class AddGroupViewController: UIViewController {
    
    @IBOutlet weak var groupNameTextField: UITextField! {
        didSet {
            groupNameTextField.placeholder = "グループ名を入力"
        }
    }
    @IBOutlet weak var addGroupButton: UIButton! {
        didSet {
            addGroupButton.setTitle("グループを作成", for: .normal)
        }
    }
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGroupButton.rx.tap.subscribe { _ in
            // TODO: グループ追加のPOST
        }
        .disposed(by: disposeBag)
        
        groupNameTextField.rx.controlEvent(.editingDidEndOnExit).asDriver()
            .drive(onNext: { _ in
                self.groupNameTextField.resignFirstResponder()
            })
            .disposed(by: disposeBag)
    }
}
