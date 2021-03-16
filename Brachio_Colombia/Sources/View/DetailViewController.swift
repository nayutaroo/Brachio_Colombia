//
//  DetailViewController.swift
//  Brachio_Colombia
//
//  Created by 山根大生 on 2021/03/15.
//

import UIKit

class DetailViewController: UIViewController {

    private let profile: Profile
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.text = profile.name
        }
    }
    
    @IBOutlet weak var messageLabel: UILabel! {
        didSet {
            messageLabel.text = profile.message
        }
    }
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = 10
            imageView.loadImage(from: profile.imageUrl)
//            imageView.layer.shadowColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
//            imageView.layer.shadowOpacity = 0.6
//            imageView.layer.shadowOffset = CGSize(width: 0, height: 3)
        }
    }
    
    init(profile: Profile) {
        self.profile = profile
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addBackground(name: "tree")
    }
}
