//
//  NavigationViewController.swift
//  Brachio_Colombia
//
//  Created by 化田晃平 on R 3/03/16.
//

import UIKit

final class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.barTintColor = .white
        navigationBar.tintColor = .brown
        navigationBar.titleTextAttributes
            = [NSAttributedString.Key.font: UIFont(name: "Times New Roman", size: 25)!, NSAttributedString.Key.foregroundColor: UIColor.brown]
    }
}
