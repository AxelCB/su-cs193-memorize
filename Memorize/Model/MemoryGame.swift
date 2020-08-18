import Foundation

struct MemoryGame<CardContent: Equatable> {
    private(set) var cards: Array<Card>
    
    init(pairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<pairsOfCards  {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
    }
    
    mutating func choose(card chosenCard: Card) {
        if let chosenCardIndex = cards.firstIndex(matching: chosenCard), !cards[chosenCardIndex].isFaceUp, !cards[chosenCardIndex].isMatched {
            cards[chosenCardIndex].isFaceUp = true
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        let id: Int
    }
}
