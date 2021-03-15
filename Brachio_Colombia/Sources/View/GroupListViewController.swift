//
//  GroupListViewController.swift
//  Brachio_Colombia
//
//  Created by 山根大生 on 2021/03/15.
//

import UIKit
import RxSwift
import RxCocoa

class GroupListViewController: UIViewController {

    @IBOutlet weak var collectonView: UICollectionView!
    @IBOutlet weak var toAddGroupButton: UIButton! {
        didSet {
            toAddGroupButton.setTitle("+", for: .normal)
        }
    }
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toAddGroupButton.rx.tap.subscribe { _ in
            let vc = AddGroupViewController()
            //vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        .disposed(by: disposeBag)
    }
}

extension GroupListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ProfileListViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension GroupListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(ProfileListCell.self, for: indexPath)
        return cell
    }
    
}
