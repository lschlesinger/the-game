//
//  Created by Lorena Schlesinger on 23.01.21.
//

import Apodini
import TheGameApodiniLibrary

struct GetGames: Handler {

    func handle() throws -> [String: Game] {
        return GameStore.instance.elements
    }
}
