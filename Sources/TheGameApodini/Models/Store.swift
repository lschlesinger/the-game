//
//  Created by Lorena Schlesinger on 23.01.21.
//

import Foundation

protocol InMemoryStore {
    associatedtype Element
    static var instance: Self { get set }

    var elements: [String: Element] { get set }
}

/// Simple in-memory store for keeping track of games.
struct GameStore: InMemoryStore {
    typealias Element = Game

    static var instance = GameStore()

    var elements: [String: Game] = [:]
}

/// Simple in-memory store for keeping track of games.
struct PlayerStore: InMemoryStore {
    typealias Element = Player

    static var instance = PlayerStore()

    var elements: [String: Player] = [:]
}
