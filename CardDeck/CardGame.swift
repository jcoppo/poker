//
//  CardGame.swift
//  CardDeck
//
//  Created by Jayson Coppo on 11/23/20.
//

import Foundation

enum Suit: String, CaseIterable {
    case heart = "♥️"
    case diamond = "♦️"
    case spade = "♠️"
    case club = "♣️"
}

let Ranks = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]

class PokerGame {
    var deck = [Card]()
    var hand = [Card]()
    var numInHand = 5
    
    func newGame() {
        deck = makeDeck()
        newHand()
    }
    
    func makeDeck() -> [Card] {
        var cards = [Card]()
        for rank in Ranks {
            for suit in Suit.allCases {
                let card = Card(rank: rank, suit: suit)
                cards.append(card)
            }
        }
        cards.shuffle()
        return cards
    }
    
    func newHand() {
        if deck.count < numInHand {
            deck = makeDeck()
        }
        
        hand = Array(deck.prefix(numInHand))
        deck.removeSubrange(0..<numInHand)
    }
    
    func showHand(result: @escaping (String) -> Void) {
        if checkForRoyalFlush() {
            return result("ROYAL FLUSH!")
        }
        if checkForFourOfAKind() {
            return result("FOUR OF A KIND!")
        }
        if checkForStraightFlush() {
            return result("STRAIGHT FLUSH!")
        }
        if checkForFullHouse() {
            return result("FULL HOUSE!")
        }
        if checkForFlush() {
            return result("FLUSH!")
        }
        if checkForStraight() {
            return result("STRIAGHT!")
        }
        if checkForThreeOfAKind() {
            return result("THREE OF A KIND!")
        }
        if checkForTwoPair() {
            return result("TWO PAIR!")
        }
        if checkForPair() {
            return result("PAIR!")
        }
        return result("Nothing")
    }
    
    func replaceCard(at index: Int) {
        guard index < hand.count else {
            return
        }
        if deck.isEmpty {
            deck = makeDeck()
        }
        hand[index] = deck.removeFirst()
    }
}

// MARK: Check Hand Combinations
extension PokerGame {
    func checkForPair() -> Bool {
        var hand = self.hand
    
        while hand.count > 1 {
            let firstCard = hand.removeFirst()
            for card in hand {
                if firstCard.rank == card.rank {
                    return true
                }
            }
        }
        return false
    }
    
    func checkForTwoPair() -> Bool {
        var hand = self.hand
        var matches = 0
        
        while hand.count > 1 {
            let firstCard = hand.removeFirst()
            for card in hand {
                if firstCard.rank == card.rank {
                    matches += 1
                }
            }
        }

        return matches == 2
    }
    
    func checkForThreeOfAKind() -> Bool {
        var hand = self.hand
        
        while hand.count > 1 {
            let firstCard = hand.removeFirst()
            var matches = 0

            for card in hand {
                if firstCard.rank == card.rank {
                    matches += 1
                }
                if matches == 2 {
                    return true
                }
            }
        }

        return false
    }
    
    func checkForStraight() -> Bool {
        var hand = self.hand
        hand = sortedByRank(hand)
    
        while hand.count > 1 {
            let card1 = hand.removeFirst()
            let card2 = hand.first!
            let rank1 = Ranks.firstIndex(of: card1.rank)!
            let rank2 = Ranks.firstIndex(of: card2.rank)!
            if rank1 + 1 != rank2 {
                return false
            }
        }

        return true
    }
    
    func checkForFlush() -> Bool {
        var hand = self.hand
        let firstCard = hand.removeFirst()
        for card in hand {
            if firstCard.suit != card.suit {
                return false
            }
        }
        return true
    }
    
    func checkForFullHouse() -> Bool {
        var rank1: String?
        var rank2: String?
        
        var numberOfRank1 = 0
        var numberOfRank2 = 0
        
        for card in hand {
            if let rank1 = rank1 {
                if card.rank == rank1 {
                    numberOfRank1 += 1
                    continue
                }
            } else {
                rank1 = card.rank
                numberOfRank1 += 1
                continue
            }
            
            if let rank2 = rank2 {
                if card.rank == rank2 {
                    numberOfRank2 += 1
                    continue
                }
            } else {
                rank2 = card.rank
                numberOfRank2 += 1
                continue
            }
        }

        let fullHouse1 = numberOfRank1 == 3 && numberOfRank2 == 2
        let fullHouse2 = numberOfRank1 == 2 && numberOfRank2 == 3
        return fullHouse1 || fullHouse2
    }
    
    func checkForStraightFlush() -> Bool {
        return checkForStraight() && checkForFlush()
    }
    
    func checkForFourOfAKind() -> Bool {
        var hand = self.hand
        
        while hand.count > 1 {
            let firstCard = hand.removeFirst()
            var matches = 0

            for card in hand {
                if firstCard.rank == card.rank {
                    matches += 1
                }
                if matches == 3 {
                    return true
                }
            }
        }

        return false
    }
    
    func checkForRoyalFlush() -> Bool {
        if !checkForStraightFlush() {
            return false
        }
        
        var hand = self.hand
        hand = sortedByRank(hand)
        
        let handRanks = hand.map {
            return $0.rank
        }
        
        return handRanks == ["10", "J", "Q", "K", "A"]
    }
    
    // MARK: helpers
    
    func sortedByRank(_ hand: [Card]) -> [Card] {
        return hand.sorted {
            let rankA = Ranks.firstIndex(of: $0.rank)!
            let rankB = Ranks.firstIndex(of: $1.rank)!
            return rankA < rankB
        }
    }
}
