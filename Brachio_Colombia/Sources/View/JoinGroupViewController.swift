//
//  JoinGroupViewController.swift
//  Brachio_Colombia
//
//  Created by 化田晃平 on R 3/03/17.
//

import UIKit
import RxSwift
import RxCocoa

class JoinGroupViewController: UIViewController {

    @IBOutlet weak var groupIdTextField: UITextField!
    
    
    @IBOutlet weak var joinButton: UIButton! {
        didSet {
            joinButton.setTitle("join", for: .normal)
            joinButton.setTitle("グループを作成", for: .normal)
            joinButton.cornerRadius = 25
            joinButton.shadowOffset = CGSize(width: 3, height: 3)
            joinButton.shadowColor = .black
            joinButton.shadowOpacity = 0.6
        }
    }
    
    private let disposeBag = DisposeBag()
    private let groupRepository: GroupRepository
    private let groupsRelay: BehaviorRelay<[Group]>
    
    init(groupRepository: GroupRepository = .init(), groupsRelay: BehaviorRelay<[Group]>) {
        self.groupRepository = groupRepository
        self.groupsRelay = groupsRelay
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addBackground(name: "tree")
        
        joinButton.rx.tap.bind(to: Binder(self) { me, _ in
            me.join()
            me.dismiss(animated: true)
        })
        .disposed(by: disposeBag)
    }
    
    private func join() {
        guard let groupId = groupIdTextField.text else {
            return
        }
        
        groupRepository.join(groupId: groupId) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print(error)
            case .success(let group):
                self.groupsRelay.accept(self.groupsRelay.value + [group])
            }
        }
    }
}
