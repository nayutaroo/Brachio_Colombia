//
//  ProfileListViewController.swift
//  Brachio_Colombia
//
//  Created by 山根大生 on 2021/03/15.
//

import UIKit

class ProfileListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.registerNib(ProfileListCollectionViewCell.self)
            let backGround
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
