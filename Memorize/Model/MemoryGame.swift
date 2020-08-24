import Foundation

struct MemoryGame<CardContent: Equatable> {
    private(set) var cards: Array<Card>
    private(set) var score: Int = 0
    private var indexOfTheOnlyAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp && !cards[$0].isMatched }.only
        }
        set {
            for cardIndex in cards.indices {
                cards[cardIndex].wasSeen = cards[cardIndex].wasSeen || cards[cardIndex].isFaceUp
                cards[cardIndex].isFaceUp = cardIndex == newValue
            }
        }
    }
    
    init(pairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<pairsOfCards  {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards = cards.shuffled()
    }
    
    mutating func choose(card chosenCard: Card) {
        if let chosenCardIndex = cards.firstIndex(matching: chosenCard), !cards[chosenCardIndex].isFaceUp, !cards[chosenCardIndex].isMatched {
            if let faceUpNotMatchedCardIndex = indexOfTheOnlyAndOnlyFaceUpCard {
                if cards[faceUpNotMatchedCardIndex].content == cards[chosenCardIndex].content {
                    cards[chosenCardIndex].isMatched = true
                    cards[faceUpNotMatchedCardIndex].isMatched = true
                    score += 2
                } else {
                    score -= [cards[chosenCardIndex], cards[faceUpNotMatchedCardIndex]].filter { $0.wasSeen }.count
                }
                cards[chosenCardIndex].isFaceUp = true
            } else {
                indexOfTheOnlyAndOnlyFaceUpCard = chosenCardIndex
            }
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var wasSeen = false
        let content: CardContent
        let id: Int
    }
}
