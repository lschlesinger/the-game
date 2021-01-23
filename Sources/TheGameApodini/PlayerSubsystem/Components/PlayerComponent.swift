//
//  Created by Lorena Schlesinger on 23.01.21.
//

import Apodini
import ApodiniDatabase

struct PlayerComponent: Component {
    var content: some Component {
        Group("player") {
            Create<Player>()
        }
    }
}
