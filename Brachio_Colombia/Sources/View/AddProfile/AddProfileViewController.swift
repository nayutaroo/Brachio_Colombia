//
//  AddProfileViewController.swift
//  Brachio_Colombia
//
//  Created by 山根大生 on 2021/03/15.
//

import UIKit
import RxSwift
import RxCocoa

final class AddProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //ライブラリから取得した画像をボタンに貼り付けるために@IBOutletで宣言
    @IBOutlet private weak var imageButton: UIButton!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var messageTextView: UITextView!
    @IBOutlet private weak var addProfileButton: UIButton! {
        didSet {
            addProfileButton.cornerRadius = 25
            addProfileButton.shadowOffset = CGSize(width: 3, height: 3)
            addProfileButton.shadowColor = .black
            addProfileButton.shadowOpacity = 0.6
        }
    }
    
    private var selectedImage: UIImage?
    private var profile: Profile?
    
    private let profileRepository: ProfileRepository
    private let profilesRelay: BehaviorRelay<[Profile]>
    
    private let disposeBag = DisposeBag()
    
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
        
        addProfileButton.rx.tap
            .subscribe(Binder(self) { me, _ in
                me.addProfile()
            })
            .disposed(by: disposeBag)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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

    @IBAction private func addPhotoButton(_ sender: Any) {
        //ライブラリにアクセス
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            
            picker.allowsEditing = true
            present(picker, animated: true, completion: nil)
        }
    }
    
    
    
    private func addProfile() {
        let storage: DBStorage = .shared
        
        guard let image = selectedImage else {
            showErrorMessageAlert(with: "画像を選択してください")
            return
        }
        
        guard let name = nameTextField.text, !name.isEmpty else {
            showErrorMessageAlert(with: "名前を入力してください")
            return
        }
        guard let message = messageTextView.text, !message.isEmpty else {
            showErrorMessageAlert(with: "メッセージを入力してください")
            return
        }
        
        storage.uploadImage(image: image) { [weak self] result in
            guard let me = self else { return }
            switch result {
            case .success(let imageUrl):
                me.profile = Profile(name: name, message: message, imageUrl: imageUrl)
                me.profileCreate()
            case .failure(let error):
                me.showErrorAlert(with: error)
                return
            }
        }
    }
    
    private func profileCreate() {
        guard let groupId = UserDefaults.standard.object(forKey: "groupId") as? String else {
            fatalError("GroupIDが取得できません")
        }
        
        guard let profile = profile else {
            return
        }
        
        profileRepository.create(groupId: groupId, profile: profile) { [weak self] result in
            guard let me = self else { return }
            switch result {
            case .failure(let error):
                me.showErrorAlert(with: error)
                return
            case .success():
                me.profilesRelay.accept(me.profilesRelay.value + [profile])
            }
        }
        dismiss(animated: true, completion: nil)
        
    }
}
