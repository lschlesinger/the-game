//
//  Created by Lorena Schlesinger on 23.01.21.
//

/// Base protocol for shuffling cards in piles, stacks or whatsoever.
protocol Shuffleable {
    mutating func shuffle()
}

extension Stack: Shuffleable {
    mutating func shuffle() {
        self.storage.shuffle()
    }
}

extension DrawPile: Shuffleable {
    mutating func shuffle() {
        self.stack.shuffle()
    }
}
