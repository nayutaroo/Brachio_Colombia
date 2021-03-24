//
//  ProfileListCell.swift
//  Brachio_Colombia
//
//  Created by 化田晃平 on R 3/03/15.
//

import UIKit
import Nuke

final class ProfileListCell: UICollectionViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView! {
        didSet {
            iconImageView.contentMode = .scaleAspectFill
            iconImageView.layer.cornerRadius = 10
        }
    }

    func configure(with profile: Profile) {
        nameLabel.text = profile.name
        iconImageView.loadImage(from: profile.imageUrl)
    }
}
