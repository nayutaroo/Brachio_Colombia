//
//  UICollectionView+.swift
//  Colombia
//
//  Created by 化田晃平 on R 3/02/17.
//
import UIKit

extension UICollectionView {
    func registerNib<T: UICollectionViewCell>(_ type: T.Type) {
        let nib = UINib(nibName: type.className, bundle: nil)
        register(nib, forCellWithReuseIdentifier: type.className)
    }

    func registerClass<T: UICollectionViewCell>(_ type: T.Type) {
        register(T.self, forCellWithReuseIdentifier: type.className)
    }

    func dequeue<T: UICollectionViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as? T else {
            fatalError("Failed to dequeue cell")
        }
        return cell
    }
}
