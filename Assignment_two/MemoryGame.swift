//
//  MemoryGame.swift
//  Assignment_two
//
//  Created by Joe on 2020-07-23.
//  Copyright © 2020 Joe. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    var cards: Array<Card>
    
    var indexOfTheOneAndOnlyFaceUpCard: Int?{
        get{
            cards.indices.filter { cards[$0].isFaceUp}.only
        }
        set{
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue            }
        }
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        
        cards = cards.shuffled()
    }
    
    mutating func choose(card: Card) {
        if let chosenIndex: Int = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    
                    EmojiMemoryGame.score += 2
                }else{
     
                    if cards[chosenIndex].seen == true {
                        EmojiMemoryGame.score -= 1
                    }
                    if cards[potentialMatchIndex].seen == true {
                           EmojiMemoryGame.score -= 1
                    }

                    cards[chosenIndex].seen = true
                    cards[potentialMatchIndex].seen = true
                }

                self.cards[chosenIndex].isFaceUp = true

            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp:Bool = false
        var isMatched: Bool = false
        var seen: Bool = false
        var content: CardContent
        var id: Int
    }
}
