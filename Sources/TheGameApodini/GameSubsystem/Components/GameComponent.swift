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
            CreateGame()
                .operation(.create)
            Group($gameId) {
                GetGame(gameId: $gameId)
                Group("join") {
                    JoinGame(gameId: $gameId)
                        .operation(.update)
                }
                Group("start") {
                    StartGame(gameId: $gameId)
                        .operation(.update)
                }
                Group("play") {
                    PlayGame(gameId: $gameId)
                        .operation(.update)
                }
                Group("pass") {
                    PassGame(gameId: $gameId)
                        .operation(.update)
                }
            }
        }
    }
}
