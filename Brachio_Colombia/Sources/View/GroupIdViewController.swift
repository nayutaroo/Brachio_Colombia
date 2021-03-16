//
//  GroupIdViewController.swift
//  Brachio_Colombia
//
//  Created by 山根大生 on 2021/03/17.
//

import UIKit

class GroupIdViewController: UIViewController {
    @IBOutlet weak var groupIdLabel: UILabel! {
        didSet {
            groupIdLabel.text = groupId
        }
    }
    
    init(groupId: String) {
        self.groupId = groupId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let groupId: String
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addBackground(name: "tree")
        

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
