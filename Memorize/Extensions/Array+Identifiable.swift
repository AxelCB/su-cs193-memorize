import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching element: Element) -> Int?  {
        return firstIndex {
            $0.id == element.id
        }
    }
}
