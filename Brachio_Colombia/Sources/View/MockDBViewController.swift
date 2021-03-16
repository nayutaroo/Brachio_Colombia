//
//  MockDBViewController.swift
//  Brachio_Colombia
//
//  Created by 化田晃平 on R 3/03/16.
//

import UIKit
import RxSwift
import RxCocoa
import Firebase

class MockDBViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton! {
        didSet {
            button.setTitle("グループ追加", for: .normal)
        }
    }
    @IBOutlet weak var button2: UIButton! {
        didSet {
            button2.setTitle("プロフィール追加", for: .normal)
        }
    }
    @IBOutlet weak var button3: UIButton! {
        didSet {
            button3.setTitle("グループ一覧表示", for: .normal)
        }
    }
    @IBOutlet weak var button4: UIButton! {
        didSet {
            button4.setTitle("プロフィール表示", for: .normal)
        }

    }
    
    private let dbClient: DBClient = .shared
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dbClient.login(email: "aiueo@gmail.com", password: "aiueoaiueo", completion: { _ in })

        button.rx.tap
            .bind(to: Binder(self) { me, _ in
                me.dbClient.createGroup(group: Group(name: "CATechAccel", imageUrl: ""), completion: { _ in })
            })
            .disposed(by: disposeBag)
        
//        button2.rx.tap
//            .bind(to: Binder(self) { me, _ in
//                me.dbClient.createProfile(group_id: "1ITrcN47PwVSLrqXD7L7", profile: Profile(name: "kohei", message: "ありがとう！", imageUrl: "")) { _ in }
//            })
//            .disposed(by: disposeBag)
        
        button3.rx.tap
            .bind(to: Binder(self) { me, _ in
                me.dbClient.getGroups() { result in
                    switch result {
                    case .success(let groups):
                        print(groups)
                    case .failure(let error):
                        print(error)
                    }
                }
            })
            .disposed(by: disposeBag)
        
        button4.rx.tap
            .bind(to: Binder(self) { me, _ in
                me.dbClient.getProfiles(groupId: "1ITrcN47PwVSLrqXD7L7") { result in
                    switch result {
                    case .success(let profiles):
                        print(profiles)
                    case .failure(let error):
                        print(error)
                    }
                }
            })
            .disposed(by: disposeBag)
    }
}
