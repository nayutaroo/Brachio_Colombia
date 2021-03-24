//
//  GroupIdViewController.swift
//  Brachio_Colombia
//
//  Created by 山根大生 on 2021/03/17.
//

import UIKit
import RxSwift
import RxCocoa


final class GroupIdViewController: UIViewController {
    @IBOutlet private weak var clipBoardNotificationLabel: UILabel! {
        didSet {
            clipBoardNotificationLabel.alpha = 0
        }
    }
    
    @IBOutlet private weak var groupIdButton: UIButton! {
        didSet {
            groupIdButton.setTitle(groupId, for: .normal)
            groupIdButton.cornerRadius = 25
            groupIdButton.shadowOffset = CGSize(width: 3, height: 3)
            groupIdButton.shadowColor = .black
            groupIdButton.shadowOpacity = 0.6
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
                me.showLabel()
            })
            .disposed(by: disposeBag)
    }
    
    private func showLabel() {
        clipBoardNotificationLabel.alpha = 1.0
        UIView.animate(withDuration: 0.3, delay: 3.0, options: .curveEaseOut, animations: { [weak self] in
            guard let me = self else { return }
            me.clipBoardNotificationLabel.alpha = 0
        }, completion: nil)
    }
}
