//
//  ProfileListCell.swift
//  Brachio_Colombia
//
//  Created by 化田晃平 on R 3/03/15.
//

import UIKit


class ProfileListCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView! {
        didSet {
            iconImageView.contentMode = .scaleAspectFill
            iconImageView.layer.cornerRadius = 10
//            iconImageView.shadowColor = .black
//            iconImageView.shadowOffset = CGSize(width: 5, height: 5)
//            iconImageView.shadowRadius = 5
//            iconImageView.layer.shadowOpacity = 1
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

}
