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
    
    init( profileRepository: ProfileRepository = .init()) {
        self.profileRepository = profileRepository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 0, bottom: 10, trailing: 0)
            let layout = UICollectionViewCompositionalLayout(section: section)
            
            collectionView.collectionViewLayout = layout
        }
    }
    
    private let profileRepository: ProfileRepository
    
    private let profilesRelay = BehaviorRelay<[Profile]>(value: [])
    
    
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        fetch()
        
        addProfileButton.rx.tap
            .bind(to: Binder(self) { me, _ in
                let vc = AddProfileViewController(profilesRelay: me.profilesRelay)
                me.present(vc, animated: true)
            })
            .disposed(by: disposeBag)
        
        
        profilesRelay.asDriver()
            .drive( Binder(self) { me, _ in
                me.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    private func viewSetup() {
        title = "Members"
        view.addBackground(name: "tree")
    }

    
    private func fetch() {
        guard let groupId = UserDefaults.standard.object(forKey: "groupId") as? String else {
            print("group取得エラー")
            return
        }
        
        profileRepository.fetch(groupId: groupId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let profiles):
                print(profiles)
                self.profilesRelay.accept(profiles)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension ProfileListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController(profile: profilesRelay.value[indexPath.row])
        print(indexPath)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProfileListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        profilesRelay.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(ProfileListCell.self, for: indexPath)
        cell.configure(with: profilesRelay.value[indexPath.row])
        return cell
    }
    
    
}
