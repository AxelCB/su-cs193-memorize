import SwiftUI

struct GridView<Element, ElementView>: View where Element: Identifiable, ElementView: View {
    let elements: [Element]
    let viewForElement: (Element) -> ElementView
    
    init(_ elements: [Element], viewForElement: @escaping (Element) -> ElementView) {
        self.elements = elements
        self.viewForElement = viewForElement
    }
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: GridLayoutView(itemCount: self.elements.count, in: geometry.size))
        }
    }
    
    func body(for layout: GridLayoutView) -> some View {
        ForEach(elements) { element in
            self.body(for: element, in: layout)
        }
    }

    func body(for element: Element, in layout: GridLayoutView) -> some View {
        viewForElement(element)
            .frame(width: layout.itemSize.width, height: layout.itemSize.height)
            .position(layout.location(ofItemAt: elements.firstIndex(matching: element)!))
    }
}
