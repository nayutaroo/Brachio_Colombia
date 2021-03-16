//
//  JoinGroupViewController.swift
//  Brachio_Colombia
//
//  Created by 化田晃平 on R 3/03/17.
//

import UIKit

class JoinGroupViewController: UIViewController {

   
    
    @IBOutlet weak var groupIdTextField: UITextField!
    @IBOutlet weak var joinButton: UIButton! {
        didSet {
            joinButton.setTitle("join", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
