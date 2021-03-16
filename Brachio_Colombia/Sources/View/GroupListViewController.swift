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
    
    private let groupsRelay = BehaviorRelay<[Group]>(value: [])
    private var groups: [Group] {
        return groupsRelay.value
    }
    private let groupRepository = GroupRepository()

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
        fetch()
        
        toAddGroupButton.rx.tap.subscribe { [weak self] _ in
            guard let self = self else { return }
            let vc = AddGroupViewController(groupsRelay: self.groupsRelay)
            //vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        .disposed(by: disposeBag)
        
        groupsRelay.asDriver().drive(Binder(self) { me, _ in
            me.collectionView.reloadData()
        })
        .disposed(by: disposeBag)
    }
    
    private func viewSetup() {
        title = "Groups"
        view.addBackground(name: "tree")
    }
    
    private func fetch() {
        groupRepository.fetch {[weak self] result in
            switch result {
            case .success(let groups):
                self?.groupsRelay.accept(groups)
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension GroupListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let id = groups[indexPath.row].id {
            UserDefaults.standard.set(id, forKey: "groupId")
            let vc = ProfileListViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
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
