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
    
    var score: Int {
        memoryGame.score
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
    
    var themeName: String {
        theme.name
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
    
    struct Theme: CaseIterable {
        let name: String
        let emojis: [String]
        let pairsOfCards: Int
        let facingDownCardBackgroundColor: Color
        let facingUpCardBackgroundColor: Color
        let boardBackgroundColor: Color
        
        private init(name: String, emojis: [String], pairsOfCards: Int? = nil, facingDownCardBackgroundColor: Color = Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)) , facingUpCardBackgroundColor: Color = Color.gray, boardBackgroundColor: Color = Color.white) {
            self.name = name
            self.emojis = emojis
            self.pairsOfCards = pairsOfCards ?? Int.random(in: 3...MemorizeConstants.ViewModel.maximumPairsOfCards)
            self.facingDownCardBackgroundColor = facingDownCardBackgroundColor
            self.facingUpCardBackgroundColor = facingUpCardBackgroundColor
            self.boardBackgroundColor = boardBackgroundColor
        }
        
        // MARK: - Predefined Themes
        static let animals = Theme(name: NSLocalizedString("animalsThemeName", comment: "Animal based theme name"), emojis: ["🐶", "🐱", "🐰", "🦁", "🐨", "🐼", "🐵", "🐞", "🐙", "🦕", "🐬", "🕷", "🦋", "🦀"], facingDownCardBackgroundColor: Color(#colorLiteral(red: 0, green: 0.3091007502, blue: 0.355339668, alpha: 1)), facingUpCardBackgroundColor: Color(#colorLiteral(red: 0.7464684775, green: 0.7464684775, blue: 0.7464684775, alpha: 1)))
        static let sports = Theme(name: NSLocalizedString("sportsThemeName", comment: "Sport based theme name"), emojis: ["🏓", "🎱", "🥏", "🏐", "🎾", "⚾️", "🏈", "🏀", "⚽️", "🏸", "🏒", "🏹", "🛹", "⛷", "🏂", "🏄🏻‍♂️", "🏊🏻‍♀️", "🧗🏻‍♂️", "🚵🏻‍♂️"], facingDownCardBackgroundColor: Color(#colorLiteral(red: 0.862745098, green: 0.3333333333, blue: 0.2235294118, alpha: 1)), facingUpCardBackgroundColor: Color(#colorLiteral(red: 0.1577261992, green: 0.1577261992, blue: 0.1577261992, alpha: 1)))
        static let weather = Theme(name: NSLocalizedString("weatherThemeName", comment: "Weather based theme name"), emojis: ["☀️", "⛅️", "☁️", "🌧", "⛈", "❄️", "🌪", "🌈", "🌞", "🌛", "☃️", "☔️"], pairsOfCards: 5, facingDownCardBackgroundColor: Color(#colorLiteral(red: 0.1315022111, green: 0.08890939504, blue: 0.506097436, alpha: 1)), facingUpCardBackgroundColor: Color(#colorLiteral(red: 0.03165959939, green: 0.03167161718, blue: 0.03165801242, alpha: 1)))
        static let food = Theme(name: NSLocalizedString("foodThemeName", comment: "Food based theme name"), emojis: ["🥐", "🧀", "🥨", "🍞", "🥓", "🍗", "🥩", "🌭", "🍔", "🍟", "🍕", "🥪", "🥙", "🌮", "🥗", "🥘"], facingDownCardBackgroundColor: Color(#colorLiteral(red: 0.347515647, green: 0.01629785276, blue: 0.5989394077, alpha: 1)), facingUpCardBackgroundColor: Color(#colorLiteral(red: 0.1945320985, green: 0.5961754724, blue: 0.9507630814, alpha: 1)))
        static let arts = Theme(name: NSLocalizedString("artThemeName", comment: "Art based theme name"), emojis: ["🎭", "🎨", "🎬", "🎤", "🎧", "🎼", "🎹", "🥁", "🎷", "🎺", "🎸", "🎻"], pairsOfCards: 5, facingDownCardBackgroundColor: Color(#colorLiteral(red: 0.8413994368, green: 0, blue: 0.5007284254, alpha: 1)), facingUpCardBackgroundColor: Color(#colorLiteral(red: 0.08369358629, green: 0.720156908, blue: 0.7133956552, alpha: 1)))
        static let flags = Theme(name: NSLocalizedString("flagThemeName", comment: "Flag based theme name"), emojis: ["🇦🇫", "🇦🇽", "🇦🇱", "🇩🇿", "🇦🇸", "🇦🇩", "🇦🇴", "🇦🇮", "🇦🇶", "🇦🇬", "🇦🇷", "🇦🇲", "🇦🇼", "🇦🇺", "🇦🇹", "🇦🇿", "🇧🇸", "🇧🇭", "🇧🇩", "🇧🇧", "🇧🇾", "🇧🇪", "🇧🇿", "🇧🇯", "🇧🇲", "🇧🇹", "🇧🇴", "🇧🇦", "🇧🇼", "🇧🇷", "🇮🇴", "🇻🇬", "🇧🇳", "🇧🇬", "🇧🇫", "🇧🇮", "🇰🇭", "🇨🇲", "🇨🇦", "🇮🇨", "🇨🇻", "🇧🇶", "🇰🇾", "🇨🇫", "🇹🇩", "🇨🇱", "🇨🇳", "🇨🇽", "🇨🇨"], facingDownCardBackgroundColor: Color(#colorLiteral(red: 0.835042417, green: 0.7542561889, blue: 0.6254884601, alpha: 1)), facingUpCardBackgroundColor: Color(#colorLiteral(red: 0.5957826126, green: 0.5957826126, blue: 0.5957826126, alpha: 1)))
        static let fruitsAndVegetables = Theme(name: NSLocalizedString("fruitVegetableThemeName", comment: "Fruits and vegetables based theme name"), emojis: ["🥕", "🌽", "🍅", "🍆", "🥑", "🥦", "🥬", "🥝", "🥥", "🌶", "🍍", "🥭", "🍑", "🍒", "🍈", "🍓", "🍇", "🍉", "🍏", "🍎", "🍐", "🍊", "🍋", "🍌"], pairsOfCards: 5, facingDownCardBackgroundColor: Color(#colorLiteral(red: 0.6618269898, green: 0.8815974746, blue: 0, alpha: 1)), facingUpCardBackgroundColor: Color(#colorLiteral(red: 0.3980560555, green: 0.5, blue: 0.003100888542, alpha: 1)))
        
        
        // MARK: - CaseIterable
        
        /// A type that can represent a collection of all values of this type.
        typealias AllCases = Array<Theme>

        /// A collection of all values of this type.
        static var allCases: AllCases {
            get {
                return [
                    .animals,
                    .sports,
                    .weather,
                    .food,
                    .arts,
                    .flags,
                    .fruitsAndVegetables,
                ]
            }
        }
    }
}
