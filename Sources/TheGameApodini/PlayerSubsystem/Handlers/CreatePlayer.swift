//
//  Created by Lorena Schlesinger on 23.01.21.
//

import Apodini
import TheGameApodiniLibrary

struct CreatePlayer: Handler {
    @Parameter
    var name: String

    func handle() throws -> Player {
        let player = Player(name: name)
        PlayerStore.instance.elements[player.id] = player
        return player
    }
}
