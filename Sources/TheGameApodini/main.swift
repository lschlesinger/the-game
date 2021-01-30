import Apodini

struct TheGameWebService: WebService {
    var content: some Component {
        PlayerComponent()
        GameComponent()
    }
}

try TheGameWebService.main()
