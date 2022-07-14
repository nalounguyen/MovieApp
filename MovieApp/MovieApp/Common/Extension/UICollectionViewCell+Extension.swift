//
//  UICollectionViewCell+Extension.swift
//  MovieApp
//
//  Created by Nalou Nguyen on 14/07/2022.
//

import Foundation
import UIKit

extension UICollectionReusableView {
    /// Returns the String describing self.
    static var identifier: String { return String(describing: self) }
    
    /// Returns the UINib with nibName matching the cell's identifier.
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: .main)
    }
}
