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
    
    static var theme: Theme = setTheme(name: .vegetables)
    
    static var score: Int = 0

    static func setTheme(name: ThemeOptional) -> Theme {
        
        let numberOfPairsOfCards = Int.random(in: 2..<6)
        
        switch name {
        case .hollowen:
            return Theme(name: "Hollowen",numberOfPairsOfCards: numberOfPairsOfCards,color: Color.orange,
                        emojis: ["👻", "🧙🏻‍♀️", "🧟‍♀️","💀","👽","🧙🏿","🧟‍♂️","🦹🏼‍♀️","🧛🏻‍♂️","👨🏻‍🚀"])

        case .sea:
            return Theme(name: "Sea",numberOfPairsOfCards:numberOfPairsOfCards, color: Color.blue,
                        emojis: ["🐡", "🐙", "🦐","🦞","🦀", "🐠","🐟","🐬","🐳","🐋"])
            
        case .cloud:
            return Theme(name: "Cloud", numberOfPairsOfCards: numberOfPairsOfCards, color: Color.white,
                        emojis: ["🌤", "⛅️", "🌥","☁️","🌦", "🌧","🌩","🌨"])
            
        case .fruit:
            return Theme(name: "Fruit", numberOfPairsOfCards: numberOfPairsOfCards, color: Color.yellow,
                        emojis: ["🍏", "🍎", "🍐","🍊","🍋", "🍌","🍓","🍈","🍒","🍑"])
            
        case .vegetables:
            return Theme(name: "Vegetables", numberOfPairsOfCards: numberOfPairsOfCards, color: Color.green,
                        emojis: ["🥦", "🥬", "🥒","🌽","🥕", "🧅","🥔","🍠","🍅","🍆"])
            
        case .cars:
            return Theme(name: "Cars", numberOfPairsOfCards: numberOfPairsOfCards,color: Color.gray,
                        emojis: ["🚗", "🚕", "🚙","🚌","🚎", "🏎","🚓","🚑","🚒","🚐"])
        }
    }
    
    //find a better approach, and find a better way to bind cards content
    func randomlySetTheme() {
        let themeName: Array<ThemeOptional> = [.hollowen, .sea, .cloud, .fruit, .vegetables, .cars]
        
        EmojiMemoryGame.theme = EmojiMemoryGame.setTheme(name: themeName[Int.random(in: 0..<themeName.count)])
        
        model = EmojiMemoryGame.createMemoryGame()
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
        var numberOfPairsOfCards: Int
        var color: Color
        var emojis: Array<String>
    }
    
    enum ThemeOptional {
        case hollowen, sea, cloud, fruit, vegetables, cars
    }
    
}

