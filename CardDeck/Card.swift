//
//  Card.swift
//  CardDeck
//
//  Created by Jayson Coppo on 11/23/20.
//

import Foundation

struct Card {
    var rank: String
    var suit: Suit
    
    var descirption: String {
        "\(rank) \(suit)"
    }
}
