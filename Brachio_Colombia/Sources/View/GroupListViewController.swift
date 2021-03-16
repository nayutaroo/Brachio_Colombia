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
    
    private let groups: [Group] = [Group(id: "1ITrcN47PwVSLrqXD7L7", name: "CATechAccel", imageUrl: "https://www.logodaku.com/wp-content/uploads/2018/07/pexels-photo-1043519-1-1200x630.jpg") ]
    
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
                heightDimension: .fractionalHeight(0.26)
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
        viewSetup()
        
        toAddGroupButton.rx.tap.subscribe { _ in
            let vc = AddGroupViewController()
            //vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        .disposed(by: disposeBag)
    }
    
    private func viewSetup() {
        title = "Groups"
        view.addBackground(name: "tree")
    }
}

extension GroupListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        UserDefaults.standard.set(groups[indexPath.row].id, forKey: "groupId")
        
        let vc = ProfileListViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension GroupListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        groups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(GroupListCell.self, for: indexPath)
        cell.profileNameLabel.text = groups[indexPath.row].name
        cell.profileImageView.loadImage(from: groups[indexPath.row].imageUrl)
        return cell
    }
}


import Nuke

extension UIImageView {
    func loadImage(from urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            self.image = UIImage(systemName: "photo")
            return
        }
        let options = ImageLoadingOptions(
            placeholder: UIImage(systemName: "photo"),
            transition: .fadeIn(duration: 0.33),
            failureImage: UIImage(systemName: "photo"),
            failureImageTransition: .fadeIn(duration: 0.33),
            contentModes: .init(success: .scaleAspectFill, failure: .scaleAspectFill, placeholder: .scaleAspectFill)
        )
        Nuke.loadImage(with: url, options: options, into: self)
    }
}
