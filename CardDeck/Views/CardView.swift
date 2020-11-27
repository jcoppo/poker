//
//  CardView.swift
//  CardDeck
//
//  Created by Jayson Coppo on 11/23/20.
//

import UIKit

class CardView: UIView {
    
    @IBOutlet weak var label: UILabel!
    
    var isSelected = false
    var index: Int!
    
    let selectedColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
    let normalColor = UIColor.clear

    func configure(with card: Card, index: Int) {
        label.text = "\(card.rank) \(card.suit.rawValue)"
        self.index = index
        
        setAppearance()
    }
    
    private func setAppearance() {
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1).cgColor
        layer.cornerRadius = 6
    }
    
    func isPressed() {
        isSelected.toggle()
        backgroundColor = isSelected ? selectedColor : normalColor
    }
}
