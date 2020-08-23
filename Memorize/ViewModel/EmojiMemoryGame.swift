import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var memoryGame: MemoryGame<String>
    private var theme: Theme
    
    static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        let shuffledEmojis = theme.emojis.shuffled()
        return MemoryGame<String>(pairsOfCards: theme.pairsOfCards) { pairIndex in
            shuffledEmojis[pairIndex]
        }
    }
    
    init() {
        theme = Theme.allCases.randomElement() ?? .animals
        memoryGame = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        memoryGame.cards
    }
    
    // MARK: - Access to theme specific view values
    
    var facingDownCardBackgroundColor: Color {
        theme.facingDownCardBackgroundColor
    }
    
    var facingUpCardBackgroundColor: Color {
        theme.facingUpCardBackgroundColor
    }
    
    var boardBackgroundColor: Color {
        theme.boardBackgroundColor
    }
    
    // MARK: - Intents
    
    func choose(card: MemoryGame<String>.Card) {
        memoryGame.choose(card: card)
    }
    
    func reset() {
        theme = Theme.allCases.randomElement() ?? .animals
        memoryGame = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    // MARK: - Theme
    
    enum Theme: CaseIterable {
        case animals
        case sports
        case weather
        case food
        case arts
        case flags
        case fruitsAndVegetables
        case faces
        
        var emojis: [String] {
            switch self {
            case .animals:
                return ["🐶", "🐱", "🐰", "🦁", "🐨", "🐼", "🐵", "🐞", "🐙", "🦕", "🐬", "🕷", "🦋", "🦀"]
            case .sports:
                return ["🏓", "🎱", "🥏", "🏐", "🎾", "⚾️", "🏈", "🏀", "⚽️", "🏸", "🏒", "🏹", "🛹", "⛷", "🏂", "🏄🏻‍♂️", "🏊🏻‍♀️", "🧗🏻‍♂️", "🚵🏻‍♂️"]
            case .weather:
                return ["☀️", "⛅️", "☁️", "🌧", "⛈", "❄️", "🌪", "🌈", "🌞", "🌛", "☃️", "☔️"]
            case .food:
                return ["🥐", "🧀", "🥨", "🍞", "🥓", "🍗", "🥩", "🌭", "🍔", "🍟", "🍕", "🥪", "🥙", "🌮", "🥗", "🥘"]
            case .arts:
                return ["🎭", "🎨", "🎬", "🎤", "🎧", "🎼", "🎹", "🥁", "🎷", "🎺", "🎸", "🎻"]
            case .flags:
                return ["🇦🇫", "🇦🇽", "🇦🇱", "🇩🇿", "🇦🇸", "🇦🇩", "🇦🇴", "🇦🇮", "🇦🇶", "🇦🇬", "🇦🇷", "🇦🇲", "🇦🇼", "🇦🇺", "🇦🇹", "🇦🇿", "🇧🇸", "🇧🇭", "🇧🇩", "🇧🇧", "🇧🇾", "🇧🇪", "🇧🇿", "🇧🇯", "🇧🇲", "🇧🇹", "🇧🇴", "🇧🇦", "🇧🇼", "🇧🇷", "🇮🇴", "🇻🇬", "🇧🇳", "🇧🇬", "🇧🇫", "🇧🇮", "🇰🇭", "🇨🇲", "🇨🇦", "🇮🇨", "🇨🇻", "🇧🇶", "🇰🇾", "🇨🇫", "🇹🇩", "🇨🇱", "🇨🇳", "🇨🇽", "🇨🇨"]
            case .fruitsAndVegetables:
                return ["🥕", "🌽", "🍅", "🍆", "🥑", "🥦", "🥬", "🥝", "🥥", "🌶", "🍍", "🥭", "🍑", "🍒", "🍈", "🍓", "🍇", "🍉", "🍏", "🍎", "🍐", "🍊", "🍋", "🍌"]
            default:
                return ["🚗", "🚕", "🚙", "🚌", "🚎" , "🏎", "🚓", "🚑", "🚒", "🚐", "🚚", "🚛", "🚜"]
            }
        }
        
        var pairsOfCards: Int {
            switch self {
            case .animals, .sports, .food, .flags:
                return Int.random(in: 3...MemorizeConstants.ViewModel.maximumPairsOfCards)
            default:
                return 5
            }
        }
        
        var facingDownCardBackgroundColor: Color {
            switch self {
            case .animals:
                return Color(#colorLiteral(red: 0, green: 0.3091007502, blue: 0.355339668, alpha: 1))
            case .sports:
                return Color(#colorLiteral(red: 0.862745098, green: 0.3333333333, blue: 0.2235294118, alpha: 1))
            case .weather:
                return Color(#colorLiteral(red: 0.1315022111, green: 0.08890939504, blue: 0.506097436, alpha: 1))
            case .food:
                return Color(#colorLiteral(red: 0.347515647, green: 0.01629785276, blue: 0.5989394077, alpha: 1))
            case .arts:
                return Color(#colorLiteral(red: 0.8413994368, green: 0, blue: 0.5007284254, alpha: 1))
            case .flags:
                return Color(#colorLiteral(red: 0.835042417, green: 0.7542561889, blue: 0.6254884601, alpha: 1))
            case .fruitsAndVegetables:
                return Color(#colorLiteral(red: 0.6618269898, green: 0.8815974746, blue: 0, alpha: 1))
            default:
                return Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
            }
        }
        
        var facingUpCardBackgroundColor: Color {
            switch self {
            case .animals:
                return Color(#colorLiteral(red: 0.7464684775, green: 0.7464684775, blue: 0.7464684775, alpha: 1))
            case .sports:
                return Color(#colorLiteral(red: 0.1577261992, green: 0.1577261992, blue: 0.1577261992, alpha: 1))
            case .weather:
                return Color(#colorLiteral(red: 0.03165959939, green: 0.03167161718, blue: 0.03165801242, alpha: 1))
            case .food:
                return Color(#colorLiteral(red: 0.1945320985, green: 0.5961754724, blue: 0.9507630814, alpha: 1))
            case .arts:
                return Color(#colorLiteral(red: 0.08369358629, green: 0.720156908, blue: 0.7133956552, alpha: 1))
            case .flags:
                return Color(#colorLiteral(red: 0.5957826126, green: 0.5957826126, blue: 0.5957826126, alpha: 1))
            case .fruitsAndVegetables:
                return Color(#colorLiteral(red: 0.3980560555, green: 0.5, blue: 0.003100888542, alpha: 1))
            default:
                return Color.gray
            }
        }
        
        var boardBackgroundColor: Color {
            switch self {
            case .animals:
                return Color.white
            case .sports:
                return Color.white
            case .weather:
                return Color.white
            case .food:
                return Color.white
            case .arts:
                return Color.white
            case .flags:
                return Color.white
            case .fruitsAndVegetables:
                return Color.white
            default:
                return Color.white
            }
        }
    }
}
