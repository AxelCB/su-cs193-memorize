import SwiftUI

struct GameView: View {
    @ObservedObject var emojiMemoryGame: EmojiMemoryGame
    
    var body: some View {
        VStack {
            GridView(emojiMemoryGame.cards) { card in
                CardView(card: card, facingUpBackgroundColor: self.emojiMemoryGame.facingUpCardBackgroundColor, facingDownBackgroundColor: self.emojiMemoryGame.facingDownCardBackgroundColor).onTapGesture {
                    self.emojiMemoryGame.choose(card: card)
                }
                    .padding(5)
            }
                .font(Font.largeTitle)
                .background(emojiMemoryGame.boardBackgroundColor)
            Button(action: {
                self.emojiMemoryGame.reset()
            }, label: {
                Text("New Game")
            })
        }
        
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(emojiMemoryGame: EmojiMemoryGame())
    }
}
