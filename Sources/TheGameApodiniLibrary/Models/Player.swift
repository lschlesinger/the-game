//
//  Created by Lorena Schlesinger on 23.01.21.
//
import Apodini
import Foundation

public struct Player: Content {
    typealias ID = String
    public let id: String
    var name: String?
    var hand: [Card]

    public init(name: String? = nil, hand: [Card] = []) {
        self.id = UUID().uuidString
        self.name = name
        self.hand = hand
    }
}

extension Player: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case hand
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        hand = try values.decode(Array<Card>.self, forKey: .hand)
    }
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

extension Player {
    func hasOptions(on piles: [GamePile]) -> Bool {
        var result = false
        outer: for card in self.hand {
            for pile in piles {
                if pile.validate(action: Action(playerId: self.id, gamePileId: pile.id, card: card)) {
                    result = true
                    break outer
                }
            }
        }
        return result
    }
}
