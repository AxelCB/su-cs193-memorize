import Foundation

class EmojiMemoryGame: ObservableObject {
    @Published private var memoryGame: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["🐶", "🐱", "🐰", "🦁", "🐨", "🐼", "🐵", "🐞", "🐙", "🦕", "🐬", "🕷", "🦋", "🦀"]
        return MemoryGame<String>(pairsOfCards: Int.random(in: 2...5)) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        memoryGame.cards
    }
    
    // MARK: - Intents
    
    func choose(card: MemoryGame<String>.Card) {
        memoryGame.choose(card: card)
    }
    
}
