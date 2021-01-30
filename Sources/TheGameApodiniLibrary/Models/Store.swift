//
//  Created by Lorena Schlesinger on 23.01.21.
//

protocol InMemoryStore {
    associatedtype Element
    static var instance: Self { get set }

    var elements: [String: Element] { get set }
}

/// Simple in-memory store for keeping track of games.
public struct GameStore: InMemoryStore {
    typealias Element = Game

    public static var instance = GameStore()

    public var elements: [String: Game] = [:]
}

/// Simple in-memory store for keeping track of games.
public struct PlayerStore: InMemoryStore {
    typealias Element = Player

    public static var instance = PlayerStore()

    public var elements: [String: Player] = [:]
}
