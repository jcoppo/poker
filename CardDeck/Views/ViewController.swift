//
//  ViewController.swift
//  CardDeck
//
//  Created by Jayson Coppo on 11/22/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var newHandButton: UIButton!
    @IBOutlet weak var showHandButton: UIButton!
    @IBOutlet weak var replaceCardsButton: UIButton!
    @IBOutlet weak var handStack: UIStackView!
    @IBOutlet weak var comboLabel: UILabel!
    
    let game = PokerGame()
    var cardViews = [CardView]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        game.newGame()
        buildCardsInHand()
        
        comboLabel.isHidden = true
    }
        
    @IBAction func newHandPressed(_ sender: Any) {
        game.newHand()
        buildCardsInHand()
        comboLabel.isHidden = true
    }
    
    @IBAction func showHandPressed(_ sender: Any) {
        game.showHand { resultMessage in
            self.comboLabel.text = resultMessage
            self.comboLabel.isHidden = false
        }
    }
    
    @IBAction func replaceCardsPressed(_ sender: Any) {
        let selectedCards = cardViews.filter { $0.isSelected }
        selectedCards.forEach { game.replaceCard(at: $0.index) }
        buildCardsInHand()
    }
    
    func buildCardsInHand() {
        handStack.clearSubviews()
        cardViews.removeAll()
        
        for (i, card) in game.hand.enumerated() {
            //set card
            let cardView = CardView.fromNib()
            cardView.configure(with: card, index: i)
            handStack.addArrangedSubview(cardView)
            cardViews.append(cardView)
            // set tap gesture
            let tap = UITapGestureRecognizer(target: self, action: #selector(cardSelected))
            cardView.addGestureRecognizer(tap)
        }
    }
    
    @objc func cardSelected(_ sender: UITapGestureRecognizer) {
        if let cardView = sender.view as? CardView {
            if !cardView.isSelected {
                if numberOfCardsSelected < 3 {
                    cardView.isPressed()
                }
            } else {
                cardView.isPressed()
            }
            
            replaceCardsButton.isEnabled = numberOfCardsSelected > 0
        }
    }
    
    var numberOfCardsSelected: Int {
        cardViews.filter { $0.isSelected }.count
    }
}
