//
//  Created by Lorena Schlesinger on 23.01.21.
//
import Apodini

struct Action: Content {
    let playerId: Player.ID
    let gamePileId: GamePile.ID
    let card: Card
}

extension Action: Decodable {
    enum CodingKeys: String, CodingKey {
        case playerId
        case gamePileId
        case card
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        playerId = try values.decode(Player.ID.self, forKey: .playerId)
        gamePileId = try values.decode(GamePile.ID.self, forKey: .gamePileId)
        card = try values.decode(Card.self, forKey: .card)
    }
}
