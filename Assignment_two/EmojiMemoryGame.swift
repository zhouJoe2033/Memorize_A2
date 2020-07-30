//
//  EmojiMemoryGame.swift
//  Assignment_two
//
//  Created by Joe on 2020-07-23.
//  Copyright © 2020 Joe. All rights reserved.
//

import Foundation
import SwiftUI

class  EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static var theme: Theme = setTheme(name: .cars)

    static func setTheme(name: ThemeOptional) -> Theme {
        
        switch name {
        case .hollowen:
            return Theme(name: "Hollowen",
                         emojis: ["👻", "🧙🏻‍♀️", "🧟‍♀️","💀","👽","🧙🏿","🧟‍♂️","🦹🏼‍♀️","🧛🏻‍♂️","👨🏻‍🚀"],
                         numberOfPairsOfCards: Int.random(in: 2..<6),
                         color: Color.orange)

        case .sea:
            return Theme(name: "Sea",
                         emojis: ["🐡", "🐙", "🦐","🦞","🦀", "🐠","🐟","🐬","🐳","🐋"],
                         numberOfPairsOfCards: Int.random(in: 2..<6),
                         color: Color.blue)
            
        case .cloud:
            return Theme(name: "Cloud",
                         emojis: ["🌤", "⛅️", "🌥","☁️","🌦", "🌧","🌩","🌨"],
                         numberOfPairsOfCards: Int.random(in: 2..<6),
                         color: Color.white)
            
        case .fruit:
            return Theme(name: "Fruit",
                        emojis: ["🍏", "🍎", "🍐","🍊","🍋", "🍌","🍓","🍈","🍒","🍑"],
                        numberOfPairsOfCards: Int.random(in: 2..<6),
                        color: Color.yellow)
            
        case .vegetables:
            return Theme(name: "Vegetables",
                        emojis: ["🥦", "🥬", "🥒","🌽","🥕", "🧅","🥔","🍠","🍅","🍆"],
                        numberOfPairsOfCards: Int.random(in: 2..<6),
                        color: Color.green)
            
        case .cars:
            return Theme(name: "Cars",
                        emojis: ["🚗", "🚕", "🚙","🚌","🚎", "🏎","🚓","🚑","🚒","🚐"],
                        numberOfPairsOfCards: Int.random(in: 2..<6),
                        color: Color.gray)
        }
    }

    static func createMemoryGame() -> MemoryGame<String> {
        
        return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairsOfCards){ pairIndex in
            return theme.emojis[pairIndex]
        }
    }
    
    //MARK: -- Access to the model
    var cards: Array<MemoryGame<String>.Card>{
        return model.cards
    }
    
    //MARK: -- Intent(s)
    func choose(card: MemoryGame<String>.Card){
        model.choose(card: card)
    }
    
    struct Theme{
        var name:String
        var emojis: Array<String>
        var numberOfPairsOfCards: Int
        var color: Color
    }
    
    enum ThemeOptional {
        case hollowen, sea, cloud, fruit, vegetables, cars
    }
    
}

