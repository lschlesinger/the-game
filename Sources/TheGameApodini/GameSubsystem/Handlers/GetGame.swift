//
//  Created by Lorena Schlesinger on 23.01.21.
//

import Apodini
import Foundation

struct GetGame: Handler {
    @Throws(.notFound)
    var notFound: ApodiniError

    @Parameter
    var gameId: String

    func handle() throws -> Game {
        guard let game = GameStore.instance.elements[gameId] else {
            throw notFound(description: "Game not found.")
        }
        return game
    }
}
