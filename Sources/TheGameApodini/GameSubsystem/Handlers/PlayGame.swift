//
//  Created by Lorena Schlesinger on 23.01.21.
//

import Apodini
import TheGameApodiniLibrary

struct PlayGame: Handler {
    @Throws(.notFound)
    var notFound: ApodiniError

    @Parameter
    var gameId: String

    @Parameter
    var action: Action

    func handle() throws -> Game {
        guard var game = GameStore.instance.elements[gameId] else {
            throw notFound(description: "Game not found.")
        }
        try game.play(action: action)
        GameStore.instance.elements[gameId] = game
        return game
    }
}
