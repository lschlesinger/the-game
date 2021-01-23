//
//  Created by Lorena Schlesinger on 23.01.21.
//
import Apodini
import Foundation

struct Player: Content {
    let id: UUID
    let name: String? = nil
    var hand: [Card] = []
}

extension Player: Validatable {
    func validate(action: Action) -> Bool {
        self.hand.contains { $0.number == action.card.number }
    }
}

extension Player: Equatable {
    public static func == (lhs: Player, rhs: Player) -> Bool {
        lhs.id == rhs.id
    }
}

extension Player: LosslessStringConvertible {
    var description: String {
        self.id.uuidString
    }
    
    init?(_ description: String) {
        guard let uuid = UUID(uuidString: description) else {
            return nil
        }
        self.id = uuid
    }
}

extension Player {
    func hasOptions(on piles: [GamePile]) -> Bool {
        var result = false
        outer: for card in self.hand {
            for pile in piles {
                if pile.validate(action: Action(player: self, gamePile: pile, card: card)) {
                    result = true
                    break outer
                }
            }
        }
        return result
    }
}
