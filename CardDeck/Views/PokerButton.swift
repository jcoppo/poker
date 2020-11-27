//
//  BorderButton.swift
//  CardDeck
//
//  Created by Jayson Coppo on 11/27/20.
//

import UIKit

class PokerButton: UIButton {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setAppearance()
    }
    
    func setAppearance() {
        layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
    }
}
