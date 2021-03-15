//
//  ProfileListViewController.swift
//  Brachio_Colombia
//
//  Created by 山根大生 on 2021/03/15.
//

import UIKit
import RxSwift
import RxCocoa

class ProfileListViewController: UIViewController {
    
    enum Const {
        static let numberOfItemInLine = 1
    }
    
    @IBOutlet weak var addProfileButton: UIButton! {
        didSet {
            addProfileButton.cornerRadius = 25
            addProfileButton.shadowOffset = CGSize(width: 3, height: 3)
            addProfileButton.shadowColor = .black
            addProfileButton.shadowOpacity = 0.6
            
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.registerNib(ProfileListCell.self)
            
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
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addProfileButton.rx.tap
            .bind(to: Binder(self) { me, _ in
                let vc = AddProfileViewController()
                vc.modalPresentationStyle = .fullScreen
                me.present(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

extension ProfileListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProfileListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(ProfileListCell.self, for: indexPath)
        return cell
    }
    
    
}
