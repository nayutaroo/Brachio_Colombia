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
    
    enum Const {
        static let numberOfItemInLine = 1
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.registerNib(GroupListCell.self)
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.36)
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitem: item,
                count: Const.numberOfItemInLine
            )
            let section = NSCollectionLayoutSection(group: group)
            let layout = UICollectionViewCompositionalLayout(section: section)
            collectionView.collectionViewLayout = layout
        }
    }
    @IBOutlet weak var toAddGroupButton: UIButton! {
        didSet {
            toAddGroupButton.cornerRadius = 25
            toAddGroupButton.shadowOffset = CGSize(width: 3, height: 3)
            toAddGroupButton.shadowColor = .black
            toAddGroupButton.shadowOpacity = 0.6
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
        let cell = collectionView.dequeue(GroupListCell.self, for: indexPath)
        return cell
    }
    
}
