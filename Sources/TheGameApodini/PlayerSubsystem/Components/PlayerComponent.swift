//
//  Created by Lorena Schlesinger on 23.01.21.
//

import Apodini

struct PlayerComponent: Component {
    var content: some Component {
        Group("player") {
            CreatePlayer()
                .operation(.create)
                .description("Creates a new player with a unique id.")
                .tags("api-player")
        }
    }
}
