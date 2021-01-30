//
//  Created by Lorena Schlesinger on 23.01.21.
//

import Apodini
import TheGameApodiniLibrary

struct JoinGame: Handler {
    @Throws(.notFound)
    var notFound: ApodiniError

    @Parameter
    var gameId: String

    @Parameter
    var playerId: String

    func handle() throws -> Game {
        guard let player = PlayerStore.instance.elements[playerId] else {
            throw notFound(description: "Player not found.")
        }
        guard var game = GameStore.instance.elements[gameId] else {
            throw notFound(description: "Game not found.")
        }
        game.add(player)
        GameStore.instance.elements[gameId] = game
        return game
    }
}
