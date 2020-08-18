import SwiftUI

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
         GeometryReader { geometry in
             self.body(for: geometry.size)
         }
     }
     
    private func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Text(card.content)
            } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius).fill(Color.green)
                }
            }
        }
        .aspectRatio(aspectRatio, contentMode: .fit)
        .font(Font.system(size: fontSize(for: size)))
    }
    
    // MARK: - Drawing Constants
    
    private let cornerRadius: CGFloat = 20.0
    private let edgeLineWidth: CGFloat = 3.0
    private let aspectRatio: CGFloat = 2.0/3.0
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.6
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: MemoryGame<String>.Card(content: "🧸", id: 0))
    }
}
