//
//  Created by Lorena Schlesinger on 23.01.21.
//

import Foundation
import Apodini

protocol Pile: Content {
    typealias ID = String
    var id: ID { get set }
    var stack: Stack<Card> { get set }
}

struct GamePile: Pile {
    var id: ID
    var stack: Stack<Card>

    enum Order: String, Encodable {
        case asc
        case desc
    }

    let order: Order

    init(order: Order) {
        self.id = UUID().uuidString
        self.stack = Stack<Card>()
        self.order = order
    }
}

extension GamePile {
    mutating func push(card: Card) {
        self.stack.push(card)
    }
}

extension GamePile: Validatable {
    func validate(action: Action) -> Bool {
        let card = action.card
        var valid: Bool = true
        if let top = self.stack.peek() {
            switch order {
            case .asc:
                valid = card.number > top.number || (card.number == (top.number - 10))
            case .desc:
                valid = card.number < top.number || (card.number == (top.number + 10))
            }
        }
        return valid
    }
}

struct DrawPile: Pile {
    var id: ID
    var stack: Stack<Card>
    var isEmpty: Bool {
        stack.isEmpty
    }

    init() {
        self.id = UUID().uuidString
        self.stack = Stack<Card>(array: (2...20).map { Card(number: $0) })
    }
}

extension DrawPile {
    mutating func draw(_ amount: Int) -> [Card] {
        // we shuffle before drawing to prevent inspection of the draw pile of some kind
        self.shuffle()
        var cards: [Card] = []
        for _ in 0..<amount {
            guard let card = self.stack.pop() else {
                break
            }
            cards.append(card)
        }
        return cards
    }
}
