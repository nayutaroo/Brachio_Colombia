//
//  AddProfileViewController.swift
//  Brachio_Colombia
//
//  Created by 山根大生 on 2021/03/15.
//

import UIKit
import RxSwift
import RxCocoa

class AddProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //let storage = Storage.storage()
    //ライブラリから取得した画像をボタンに貼り付けるために@IBOutletで宣言
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    
    private var selectedImage: UIImage?
    private var profile: Profile?
    
    private let profileRepository: ProfileRepository
    private let profilesRelay: BehaviorRelay<[Profile]>
    
    init(profileRepository: ProfileRepository = .init(), profilesRelay: BehaviorRelay<[Profile]>) {
        self.profileRepository = profileRepository
        self.profilesRelay = profilesRelay
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func viewSetup() {
        view.addBackground(name: "tree")
    }
    
    //表示するためのメソッド
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageButton.setImage(info[.editedImage] as? UIImage, for: .normal)
        selectedImage = info[.editedImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }

    @IBAction func addPhotoButton(_ sender: Any) {
        //ライブラリにアクセス
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            
            picker.allowsEditing = true
            present(picker, animated: true, completion: nil)
        }
    }
    
    @IBAction func addProfile(_ sender: Any) {
        let storage: DBStorage = .shared
        
        guard let name = nameTextField.text,
              let message = messageTextView.text,
              let image = selectedImage else {
            print("入力エラー")
            return
        }
        
        
        storage.uploadImage(image: image) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let imageUrl):
                self.profile = Profile(name: name, message: message, imageUrl: imageUrl)
                self.profileCreate()
            case .failure(let error):
                print(error)
                return
            }
        }
    }
    
    private func profileCreate() {
        
        guard let groupId = UserDefaults.standard.object(forKey: "groupId") as? String,
              let profile = self.profile else {
            print("group取得エラー")
            return
        }
        
        profileRepository.create(groupId: groupId, profile: profile) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print(error)
                return
            case .success():
                self.profilesRelay.accept(self.profilesRelay.value + [profile])
            }
        }
        dismiss(animated: true, completion: nil)
        
    }
}
