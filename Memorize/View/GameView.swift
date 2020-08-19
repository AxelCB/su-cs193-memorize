import SwiftUI

struct GameView: View {
    @ObservedObject var emojiMemoryGame: EmojiMemoryGame
    
    var body: some View {
        GridView(emojiMemoryGame.cards) { card in
            CardView(card: card).onTapGesture {
                self.emojiMemoryGame.choose(card: card)
            }
                .padding(5)
        }
            .font(Font.largeTitle)
            .background(Color.black)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(emojiMemoryGame: EmojiMemoryGame())
    }
}
