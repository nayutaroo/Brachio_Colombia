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
