//
//  UIView+extensions.swift
//  CardDeck
//
//  Created by Jayson Coppo on 11/23/20.
//

import UIKit

extension UIView {
    static func fromNib() -> Self {
        let bundle = Bundle(for: self)
        let nib = bundle.loadNibNamed(nibName(), owner: self, options: nil)
        return nib!.first as! Self
    }
    
    static func nibName() -> String {
        return String(describing: self)
    }
    
    func clearSubviews() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
}

