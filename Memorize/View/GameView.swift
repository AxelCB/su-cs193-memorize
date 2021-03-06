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
                Text("currentScore") + Text("\(emojiMemoryGame.score)").bold()
                Button(action: {
                    self.emojiMemoryGame.reset()
                }, label: {
                    Text("newGame")
                })
            }
                .padding(.bottom, 10)
                .navigationBarTitle("Memorize - \(emojiMemoryGame.themeName)", displayMode: .inline)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(emojiMemoryGame: EmojiMemoryGame())
    }
}
