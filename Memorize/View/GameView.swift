//
//  ContentView.swift
//  Memorize
//
//  Created by Axel Collard Bovy on 17/08/2020.
//  Copyright © 2020 Axel Collard Bovy. All rights reserved.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var emojiMemoryGame: EmojiMemoryGame
    
    var body: some View {
        HStack {
            ForEach(emojiMemoryGame.cards) { card in
                CardView(card: card).onTapGesture {
                    self.emojiMemoryGame.choose(card: card)
                }
            }
        }.padding(5)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(emojiMemoryGame: EmojiMemoryGame())
    }
}
