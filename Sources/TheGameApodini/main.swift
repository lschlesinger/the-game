import Apodini

struct TheGameWebService: WebService {
    var content: some Component {
        PlayerComponent()
        GameComponent()
    }

    var configuration: Configuration {
        HTTPConfiguration().address(.hostname("0.0.0.0", port: 8080))
    }
}

try TheGameWebService.main()
