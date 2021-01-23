//
//  Created by Lorena Schlesinger on 23.01.21.
//

import Apodini

protocol Stackable {
    associatedtype Element
    func peek() -> Element?
    mutating func push(_ element: Element)
    @discardableResult mutating func pop() -> Element?
}

extension Stackable {
    var isEmpty: Bool { peek() == nil }
}

struct Stack<T>: Stackable where T: Content {
    var storage: [T] = [T]()
    func peek() -> T? { storage.last }
    mutating func push(_ element: T) { storage.append(element) }
    mutating func pop() -> T? { storage.popLast() }
}
    
extension Stack: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Self.Element...) {
        self.init(array: elements)
    }
    
    init(array elements: [Self.Element]) {
        self.storage = elements
    }
}

extension Stack: Content {
    public func encode(to encoder: Encoder) throws {
        try self.storage.encode(to: encoder)
    }
}
