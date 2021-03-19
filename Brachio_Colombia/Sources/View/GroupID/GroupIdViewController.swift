//
//  GroupIdViewController.swift
//  Brachio_Colombia
//
//  Created by 山根大生 on 2021/03/17.
//

import UIKit
import RxSwift
import RxCocoa


class GroupIdViewController: UIViewController {
    @IBOutlet weak var groupIdButton: UIButton! {
        didSet {
            groupIdButton.setTitle(groupId, for: .normal)
            groupIdButton.cornerRadius = 25
            groupIdButton.shadowOffset = CGSize(width: 3, height: 3)
            groupIdButton.shadowColor = .black
            groupIdButton.shadowOpacity = 0.6
            clipBoardNotificationLabel.alpha = 0.0
        }
    }
    @IBOutlet weak var clipBoardNotificationLabel: UILabel! {
        didSet {
            clipBoardNotificationLabel.isHidden = true
        }
    }
    
    init(groupId: String) {
        self.groupId = groupId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let groupId: String
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addBackground(name: "tree")
        
        groupIdButton.rx.tap
            .subscribe(Binder(self) { me, _ in
                UIPasteboard.general.string = me.groupId
                me.clipBoardNotificationLabel.isHidden = false
                me.showLabel()
            })
            .disposed(by: disposeBag)
    }
    
    private func showLabel() {
        clipBoardNotificationLabel.alpha = 1.0
        UIView.animate(withDuration: 0.3, delay: 3.0, options: .curveEaseOut, animations: {
            self.clipBoardNotificationLabel.alpha = 0.0
        }, completion: nil)
    }
}
