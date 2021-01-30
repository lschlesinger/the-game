//
//  Created by Lorena Schlesinger on 23.01.21.
//

import Apodini
import TheGameApodiniLibrary

struct PassGame: Handler {
    @Throws(.notFound)
    var notFound: ApodiniError

    @Parameter
    var gameId: String

    func handle() throws -> Game {
        guard var game = GameStore.instance.elements[gameId] else {
            throw notFound(description: "Game not found.")
        }
        try game.pass()
        GameStore.instance.elements[gameId] = game
        return game
    }
}
