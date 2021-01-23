//
//  Created by Lorena Schlesinger on 23.01.21.
//

import Foundation
import Apodini

struct CreateGame: Handler {
    @Parameter
    var name: String

    func handle() throws -> Game {
        let game = Game(name: name)
        GameStore.instance.elements[game.id] = game
        return game
    }
}
