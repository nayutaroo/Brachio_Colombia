//
//  GroupListViewController.swift
//  Brachio_Colombia
//
//  Created by 山根大生 on 2021/03/15.
//

import UIKit

class GroupListViewController: UIViewController {
    
    @IBOutlet weak var toAddGroupButton: UIButton! {
        didSet {
            toAddGroupButton.setTitle("＋", for: .normal)
        }
    }
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            // TODO: なゆたが作ったCellをここでも使う
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension GroupListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //TODO
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // TODO なゆたが作ったCellをここでも使う
        let cell = UICollectionViewCell()
        return cell
    }
    
    
}
