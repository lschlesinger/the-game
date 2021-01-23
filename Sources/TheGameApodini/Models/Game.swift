//
//  Created by Lorena Schlesinger on 23.01.21.
//

import Foundation
import Apodini

fileprivate let HANDSIZE_TWO_PLAYERS = 7
fileprivate let HANDSIZE_DEFAULT = 6
fileprivate let MAX_PLAYERS = 5
fileprivate let MIN_PLAYERS = 2

/// The main game class.
struct Game: Content {
    let id: UUID
    
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
        case win
        case lose
        case none
    }
    var result: Result
    
    /// Associated players, i.e. "the team", key is player ID.
    var players: [UUID: Player]
    
    /// Player whose turn it is.
    var currentPlayer: Player? = nil
    
    /// Actions that were performed by current player.
    var currentActions: [Action] = []
    
    /// Amount of cards for a player's hand.
    var handSize: Int {
        players.count == MIN_PLAYERS ? HANDSIZE_TWO_PLAYERS : HANDSIZE_DEFAULT
    }
}

/// MARK: Game setup.
extension Game {
    public init(name: String) {
        self.id = UUID()
        self.name = name
        self.drawPile = DrawPile()
        self.gamePiles = [
            GamePile(order: .asc),
            GamePile(order: .asc),
            GamePile(order: .desc),
            GamePile(order: .desc),
        ]
        self.status = .open
        self.result = .none
        self.players = [:]
    }
    
    mutating func add(_ players: Player...) {
        for player in players {
            self.players[player.id] = player
        }
    }
}

/// MARK: Game initialization.
extension Game {
    mutating func start() throws {
        // 0.1 Check for at least MIN_PLAYERS, at most MAX_PLAYERS players.
        guard (MIN_PLAYERS...MAX_PLAYERS).contains(players.count) else {
            throw GameError("Invalid player count: \(players.count).")
        }
        
        // 0.2 Check for valid state to start a game.
        guard self.status == .open else {
            throw GameError("Can't start a game in state \(self.status).")
        }
        
        // 1. Shuffle draw pile
        self.drawPile.shuffle()
        
        // 2. Distribute cards
        distributeCards()
        
        // 3. Randomly pick start player
        self.currentPlayer = players.randomElement()?.value
        
        // 4. Change Status
        self.status = .running
        
        // TODO: 5. Emit to subscribers
        
    }
    
    private mutating func distributeCards() {
        for (playerId, player) in players {
            var player = player
            player.hand = self.drawPile.draw(self.handSize)
            players[playerId] = player
        }
    }
}

/// MARK: Game actions.
extension Game {
    /// Plays an action of the current player.
    mutating func play(action: Action) throws {
        // 0. check if player is currentPlayer
        guard action.player == currentPlayer && players[action.player.id] != nil else {
            throw GameError("It's not your turn dude.")
        }
        try perform(action: action)
        currentActions.append(action)
    }
    
    /// Pass on to the next player in row, if allowed.
    mutating func pass() throws {
        // 0. check if player performed enough actions (1,2)
        guard (!drawPile.isEmpty && currentActions.count > 1) || (drawPile.isEmpty && currentActions.count > 0) else {
            throw GameError("Still your turn dude.")
        }
        
        // 1. draw new cards (if available in draw pile)
        guard let playerId = currentPlayer?.id, var player = players[playerId] else {
            throw GameError("Current player couldn't be identified.")
        }
        player.hand.append(contentsOf: drawPile.draw(currentActions.count))
        players[playerId] = player
        
        // 2. determine next player with hand count > 0
        let orderedPlayerKeys = players.keys.sorted { $0.uuidString < $1.uuidString }
        var foundCurrentPlayer = false
        var currentKeyIdx = 0
        while self.status == .running {
            guard let player = players[orderedPlayerKeys[currentKeyIdx]] else {
                throw GameError("Failed to pass to next player.")
            }
            if foundCurrentPlayer && player.hand.count > 0 {
                self.currentPlayer = player
                self.currentActions = []
                if !player.hasOptions(on: self.gamePiles) {
                    self.result = .lose
                    self.status = .closed
                }
                break
            }
            if player == currentPlayer {
                // if all players have no cards left, this game is won
                if foundCurrentPlayer && player.hand.count == 0 {
                    self.result = .win
                    self.status = .closed
                    break
                }
                foundCurrentPlayer = true
            }
            currentKeyIdx = (currentKeyIdx + 1) % orderedPlayerKeys.count
        }
    }
    
    private mutating func perform(action: Action) throws {
        var player = players[action.player.id]
        
        // check if it is valid to put card on desired pile
        guard let gamePileIdx = gamePiles.firstIndex(where: {
            $0.id == action.gamePile.id
        }) else {
            throw GameError("Action invalid: Game pile doesn't exist.")
        }
        
        // depending on order, check if card is valid for pushing to stack
        guard gamePiles[gamePileIdx].validate(action: action) else {
            throw GameError("Action invalid: Your card can't be placed on desired pile.")
        }
        
        // check if card in player's hand
        guard (player)?.validate(action: action) ?? false else {
            throw GameError("Action invalid: You are trying to play a card that isn't in your hand.")
        }
        
        // perform action ->  update pile
        var gamePile = gamePiles[gamePileIdx]
        gamePile.push(card: action.card)
        gamePiles[gamePileIdx] = gamePile
        
        // perform action ->  update player hand
        player?.hand.removeAll(where: { $0.number == action.card.number })
        players[action.player.id] = player
    }
}
