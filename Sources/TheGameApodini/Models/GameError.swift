//
//  Created by Lorena Schlesinger on 23.01.21.
//

import Foundation

struct GameError: Error {
    let message: String

    init(_ message: String) {
        self.message = message
    }
}
