//
//  Created by Lorena Schlesinger on 23.01.21.
//

import Foundation

/// Any entity that needs to validate whether an `Action` can be performed on them.
protocol Validatable {
    func validate(action: Action) -> Bool
}
