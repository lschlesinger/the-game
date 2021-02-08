//
//  Created by Lorena Schlesinger on 23.01.21.
//

import Foundation
import Apodini

enum GameDefaults {
    static let handSizeTwoPlayers = 7
    static let handSizeDefault = 6
    static let maxPlayers = 5
    static let minPlayers = 2
}

/// The main game class.
public struct Game: Content {
    public let id: String

    /// Custom name for game.
    let name: String

    /// The draw pile.
    private var drawPile: DrawPile

    /// Four game piles.
    var gamePiles: [GamePile]

    /// Captures the current state of the game.
    enum Status: String, Encodable {
        /// Players can still join.
        case open
        /// Game with fixed players is in progress.
        case running
        /// Game is finished.
        case closed
    }
    var status: Status

    /// Indicates whether "the game" or "the team" has won or it is still undecided.
    enum Result: String, Encodable {
        case won
        case lost
        case none
    }
    var result: Result

    /// Associated players, i.e. "the team", key is player ID.
    public var players: [String: Player]

    /// Player whose turn it is.
    var currentPlayerId: Player.ID?

    /// Actions that were performed by current player.
    var currentActions: [Action] = []

    /// Amount of cards for a player's hand.
    var handSize: Int {
        players.count == GameDefaults.minPlayers ? GameDefaults.handSizeTwoPlayers : GameDefaults.handSizeDefault
    }
}

// MARK: Game setup.
public extension Game {
    init(name: String) {
        id = UUID().uuidString
        self.name = name
        drawPile = DrawPile()
        gamePiles = [
            GamePile(order: .asc),
            GamePile(order: .asc),
            GamePile(order: .desc),
            GamePile(order: .desc)
        ]
        status = .open
        result = .none
        players = [:]
    }

    mutating func add(_ players: Player...) {
        for player in players {
            self.players[player.id] = player
        }
    }
}

// MARK: Game initialization.
extension Game {
    public mutating func start() throws {
        // Check for at least GameDefaults.minPlayers, at most GameDefaults.maxPlayers players.
        guard (GameDefaults.minPlayers...GameDefaults.maxPlayers).contains(players.count) else {
            throw GameError("Invalid player count: \(players.count).")
        }

        // Check for valid state to start a game.
        guard status == .open else {
            throw GameError("Can't start a game in state \(status).")
        }

        // Distribute cards.
        distributeCards()

        // Randomly pick start player.
        currentPlayerId = players.randomElement()?.value.id

        // Change Status.
        status = .running

    }

    private mutating func distributeCards() {
        for (playerId, player) in players {
            var player = player
            player.hand = drawPile.draw(handSize)
            players[playerId] = player
        }
    }
}

// MARK: Game actions.
extension Game {
    /// Plays an action of the current player.
    public mutating func play(action: Action) throws {
        // 0. check if player is currentPlayer
        guard action.playerId == currentPlayerId && players[action.playerId] != nil else {
            throw GameError("It's not your turn dude.")
        }
        try perform(action: action)
        currentActions.append(action)
    }

    /// Perform game action of passing on to the next player in row.
    public mutating func pass() throws {
        guard let playerId = currentPlayerId, var player = players[playerId] else {
            throw GameError("Current player couldn't be identified.")
        }

        let sufficientActionsPlayed = (!drawPile.isEmpty && currentActions.count > 1) || (drawPile.isEmpty && currentActions.count > 0)

        // Check if game lost because player has not played sufficient actions, but has no options.
        if !sufficientActionsPlayed && !player.hasOptions(on: gamePiles) {
            status = .closed
            result = .lost
            removeGame()
            return
        }

        // Check if player performed enough actions (1,2).
        guard sufficientActionsPlayed else {
            throw GameError("Still your turn dude.")
        }

        // Draw new cards (if available in draw pile).
        player.hand.append(contentsOf: drawPile.draw(currentActions.count))
        players[playerId] = player

        // Determine next player with hand count > 0.
        let orderedPlayerKeys = players.keys.sorted { $0 < $1 }
        var foundCurrentPlayer = false
        var currentKeyIdx = 0
        while status == .running {
            guard let player = players[orderedPlayerKeys[currentKeyIdx]] else {
                throw GameError("Failed to pass to next player.")
            }
            if foundCurrentPlayer && player.hand.count > 0 {
                currentPlayerId = player.id
                currentActions = []
                if !player.hasOptions(on: gamePiles) {
                    result = .lost
                    status = .closed
                    removeGame()
                }
                break
            }
            if player.id == currentPlayerId {
                // If no player has cards left, this game is won.
                if foundCurrentPlayer && player.hand.count == 0 {
                    result = .won
                    status = .closed
                    removeGame()
                    break
                }
                foundCurrentPlayer = true
            }
            currentKeyIdx = (currentKeyIdx + 1) % orderedPlayerKeys.count
        }
    }

    /// Perform game action of putting a card on a pile.
    private mutating func perform(action: Action) throws {
        var player = players[action.playerId]

        // Check if it is valid to put card on chosen pile.
        guard let gamePileIdx = gamePiles.firstIndex(where: {
            $0.id == action.gamePileId
        }) else {
            throw GameError("Action invalid: Game pile doesn't exist.")
        }

        // Depending on order, check if card is valid for pushing to stack.
        guard gamePiles[gamePileIdx].validate(action: action) else {
            throw GameError("Action invalid: Your card can't be placed on desired pile.")
        }

        // Check if card in player's hand.
        guard (player)?.validate(action: action) ?? false else {
            throw GameError("Action invalid: You are trying to play a card that isn't in your hand.")
        }

        // After action is performed, update pile.
        var gamePile = gamePiles[gamePileIdx]
        gamePile.push(card: action.card)
        gamePiles[gamePileIdx] = gamePile

        // After action is performed, update player's hand.
        player?.hand.removeAll(where: { $0.number == action.card.number })
        players[action.playerId] = player
    }

    /// Schedule game for removal from in-memory store.
    private func removeGame() {
        print("Triggered game removal in t-5 min.")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 60 * 5) {
            print("Removing game \(name) from in-memory store.")
            GameStore.instance.elements.removeValue(forKey: id)
        }
    }
}
