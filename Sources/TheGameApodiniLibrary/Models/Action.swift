//
//  Created by Lorena Schlesinger on 23.01.21.
//
import Apodini

public struct Action: Content {
    let playerId: Player.ID
    let gamePileId: GamePile.ID
    let card: Card
    
    init(playerId: Player.ID, gamePileId: GamePile.ID, card: Card) {
        self.playerId = playerId
        self.gamePileId = gamePileId
        self.card = card
    }
}

extension Action: Decodable {
    enum CodingKeys: String, CodingKey {
        case playerId
        case gamePileId
        case card
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        playerId = try values.decode(Player.ID.self, forKey: .playerId)
        gamePileId = try values.decode(GamePile.ID.self, forKey: .gamePileId)
        card = try values.decode(Card.self, forKey: .card)
    }
}
