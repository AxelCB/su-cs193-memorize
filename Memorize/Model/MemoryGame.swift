import Foundation

struct MemoryGame<CardContent: Equatable> {
    private(set) var cards: Array<Card>
    private(set) var score: Int = 0
    private var lastCardChosenAt: Date?
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
                    score += computeTimeBasedScoreBonusOrPenaltyTo(score: 4)
                } else {
                    score += computeTimeBasedScoreBonusOrPenaltyTo(score: [cards[chosenCardIndex], cards[faceUpNotMatchedCardIndex]].filter { $0.wasSeen }.count * -1)
                }
                cards[chosenCardIndex].isFaceUp = true
            } else {
                indexOfTheOnlyAndOnlyFaceUpCard = chosenCardIndex
            }
            lastCardChosenAt = Date()
        }
    }
    
    private mutating func computeTimeBasedScoreBonusOrPenaltyTo(score: Int) -> Int {
        guard let lastCardChosenAt = lastCardChosenAt else {
            return 0
        }
        let secondsSinceLastChosenCard = min(Date().timeIntervalSince(lastCardChosenAt), 10)
        // Math function may be a bit complicated because of type conversions, but equivalent math function would be
        // scoreDiffence = ( (-a) * x^2 + 50 only if a was positive) * a ; where x = secondsSinceLastChosenCard , a = score
        return Int(round(Double(-score) * secondsSinceLastChosenCard.magnitudeSquared) + ((score > 0) ? 50 : 0)) * score
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var wasSeen = false
        let content: CardContent
        let id: Int
    }
}
