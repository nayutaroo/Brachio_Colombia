//
//  ProfileListCell.swift
//  Brachio_Colombia
//
//  Created by 化田晃平 on R 3/03/15.
//

import UIKit
import Nuke

class ProfileListCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView! {
        didSet {
            iconImageView.contentMode = .scaleAspectFill
            iconImageView.layer.cornerRadius = 10
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
    }

    func configure(with profile: Profile) {
        nameLabel.text = profile.name
        iconImageView.loadImage(from: profile.imageUrl)
    }
}
