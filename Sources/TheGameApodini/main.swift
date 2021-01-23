import Apodini
import ApodiniDatabase
import Foundation

struct TheGameWebService: WebService {
    var content: some Component {
        PlayerComponent()
        GameComponent()
    }
    var configuration: some Configuration {
        DatabaseConfiguration(.sqlite(.memory))
    }
}

try TheGameWebService.main()
