//
//  ContentView.swift
//  Assignment_two
//
//  Created by Joe on 2020-07-22.
//  Copyright © 2020 Joe. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: 0.3)) {
                        self.viewModel.choose(card: card)
                    }
                }
                .padding(5)
            }
                .padding()
            .foregroundColor(EmojiMemoryGame.theme.color)

            Divider()
            
//            FooterView(viewModel)
            
            HStack {
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.6)){
                        self.viewModel.resetGame()
                    }
                }, label: { Text("New Game") })
                    .padding(11)
                    .foregroundColor(Color.white)
                    .background(EmojiMemoryGame.theme.color)
                    .cornerRadius(15)

                Text(EmojiMemoryGame.theme.name)
                    .bold()
                    .padding()

                Text(String(EmojiMemoryGame.score))
                    .padding()  
            }
        }
    }
}


//struct FooterView: View {
//    private var viewModel: EmojiMemoryGame
//
//    init(_ viewModel: EmojiMemoryGame) {
//        self.viewModel = viewModel
//    }
//    var body: some View {
//        self.body(model: viewModel)
//    }
//
//    @ViewBuilder
//    private func body(model viewModel: EmojiMemoryGame) -> some View {
//        HStack {
//            Button(action: viewModel.randomlySetTheme) {
//                Text("New Game")
//            }
//                .padding()
//                .foregroundColor(Color.white)
//                .background(EmojiMemoryGame.theme.color)
//                .cornerRadius(15)
//
//            Text(EmojiMemoryGame.theme.name)
//                .bold()
//                .padding()
//
//
//            Text(String(EmojiMemoryGame.score))
//                .padding()
//        }
//        .padding()
//    }
//}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animatedBnusRemaining: Double = 0
    
    private func StartBonusTimeAnimation() {
        animatedBnusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBnusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group{
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(0-90),endAngle: Angle.degrees(-animatedBnusRemaining*360-90), clockwise:true)
                            .onAppear {
                                self.StartBonusTimeAnimation()
                        }
                    } else {
                        Pie(startAngle: Angle.degrees(0-90),endAngle: Angle.degrees(-card.bonusRemaining*360-90), clockwise:true)
                    }
                }
                    .padding(5)
                    .opacity(0.4)
                
                Text(self.card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
        }
    }

    private let fontScaleFacto: CGFloat = 0.7
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFacto
    }
}

struct  GeometryProxy {
    var size: CGSize
    var safeAreaInsets: EdgeInsets
}








struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return ContentView(viewModel: game)
    }
}
