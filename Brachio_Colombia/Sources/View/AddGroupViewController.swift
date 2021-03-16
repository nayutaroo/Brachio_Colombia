//
//  AddGroupViewController.swift
//  Brachio_Colombia
//
//  Created by 化田晃平 on R 3/03/15.
//

import UIKit
import RxSwift
import RxCocoa

final class AddGroupViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var groupNameTextField: UITextField! {
        didSet {
            groupNameTextField.delegate = self
            groupNameTextField.placeholder = "グループ名を入力"
        }
    }
    @IBOutlet weak var addGroupButton: UIButton! {
        didSet {
            addGroupButton.setTitle("グループを作成", for: .normal)
        }
    }
    @IBOutlet weak var groupImageButton: UIButton! {
        didSet {
            groupImageButton.imageView?.contentMode = .scaleAspectFit
            let image = UIImage(systemName: "photo")
            image?.withTintColor(.white)
            groupImageButton.setImage(image, for: .normal)
        }
    }
    
    private var group: Group?
    private var groupImage: UIImage?
    private let disposeBag = DisposeBag()
    private let groupRepository: GroupRepository
    private let groupsRelay: BehaviorRelay<[Group]>
    
    init(groupRepository: GroupRepository = .init(), groupsRelay: BehaviorRelay<[Group]>) {
        self.groupRepository = groupRepository
        self.groupsRelay = groupsRelay
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGroupButton.rx.tap.subscribe { [weak self] _ in
            // TODO: グループ追加のPOST
            let storage: DBStorage = .shared
            guard let self = self else { return }
            guard let name = self.groupNameTextField.text,
                  let image = self.groupImage
            else {
                print("errrpr")
                return
            }
            storage.uploadImage(image: image) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let imageUrl):
                    self.group = Group(id: nil, name: name, imageUrl: imageUrl)
                    self.groupCreate()
                case .failure(let error):
                    print(error)
                    return

                }
            }
            self.dismiss(animated: true, completion: nil)
        }
        .disposed(by: disposeBag)
        
        groupNameTextField.rx.controlEvent(.editingDidEndOnExit).asDriver()
            .drive(onNext: { _ in
                self.groupNameTextField.resignFirstResponder()
            })
            .disposed(by: disposeBag)
        
        
        groupImageButton.rx.tap
            .subscribe({ [weak self] _ in
                let picker = UIImagePickerController()
                let sourceType: UIImagePickerController.SourceType = UIImagePickerController.SourceType.photoLibrary
                guard let self = self else { return }
                if UIImagePickerController.isSourceTypeAvailable(sourceType) {
                    picker.sourceType = sourceType
                    picker.delegate = self
                    picker.allowsEditing = true
                    self.present(picker, animated: true, completion: nil)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        groupImage = info[.originalImage] as? UIImage
        groupImageButton.setImage(groupImage, for: .normal)
        dismiss(animated: true, completion: nil)
    }
    
    func groupCreate() {
        guard let group = group else { return }
        groupRepository.create(group: group)  { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success():
                self.groupsRelay.accept(self.groupsRelay.value + [group])
            case .failure(let error):
                print(error)
                return
            }
        }
    }
}
