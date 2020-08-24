import SwiftUI

struct GameView: View {
    @ObservedObject var emojiMemoryGame: EmojiMemoryGame
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                GridView(emojiMemoryGame.cards) { card in
                    CardView(card: card, facingUpBackgroundColor: self.emojiMemoryGame.facingUpCardBackgroundColor, facingDownBackgroundColor: self.emojiMemoryGame.facingDownCardBackgroundColor).onTapGesture {
                        self.emojiMemoryGame.choose(card: card)
                    }
                        .padding(5)
                }
                    .font(Font.largeTitle)
                    .background(emojiMemoryGame.boardBackgroundColor)
                Text("Current score: \(emojiMemoryGame.score)")
                Button(action: {
                    self.emojiMemoryGame.reset()
                }, label: {
                    Text("New Game")
                })
            }
            .navigationBarTitle("Memorize - \(emojiMemoryGame.themeName)", displayMode: .inline)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(emojiMemoryGame: EmojiMemoryGame())
    }
}
