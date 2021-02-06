//
//  Created by Lorena Schlesinger on 23.01.21.
//

import Apodini
import Foundation

struct GameComponent: Component {
    @PathParameter
    var gameId: String

    var content: some Component {
        Group("game") {
            GetGames()
                .description("Returns all games.")
                .tags("api-game")
            CreateGame()
                .operation(.create)
                .description("Creates a new game with a specified name as query parameter.")
                .tags("api-game")
            Group($gameId) {
                GetGame(gameId: $gameId)
                    .description("Returns the game having the id given in path.")
                    .tags("api-game")
                Group("join") {
                    JoinGame(gameId: $gameId)
                        .operation(.update)
                        .description("Adds the requesting player to players of the game having the id given in path.")
                        .tags("api-action")
                }
                Group("start") {
                    StartGame(gameId: $gameId)
                        .operation(.update)
                        .description("For the game having the id given in path, the initialization is triggered: If preconditions fulfilled, change the game with given id to status `running`, distribute cards from shuffled draw pile, randomly select start player.")
                        .tags("api-action")
                }
                Group("play") {
                    PlayGame(gameId: $gameId)
                        .operation(.update)
                        .description("For the game having the id given in path, the action of putting a card on a game pile is triggered: If are preconditions are fulfilled, the requested action - including player id, hand card and game pile - is performed.")
                        .tags("api-action")
                }
                Group("pass") {
                    PassGame(gameId: $gameId)
                        .operation(.update)
                        .description("For the game having the id given in path, the action of passing to the next player is triggered: If preconditions are fulfilled, new hand cards are drawn up and the player whose turn it is next is chosen.")
                        .tags("api-action")
                }
            }
        }
    }
}
