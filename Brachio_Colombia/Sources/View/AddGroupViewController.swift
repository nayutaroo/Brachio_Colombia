//
//  AddGroupViewController.swift
//  Brachio_Colombia
//
//  Created by 化田晃平 on R 3/03/15.
//

import UIKit
import RxSwift
import RxCocoa

final class AddGroupViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var groupNameTextField: UITextField! {
        didSet {
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
        }
    }
    
    private var groupImage: UIImage?
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGroupButton.rx.tap.subscribe { _ in
            // TODO: グループ追加のPOST
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
}
