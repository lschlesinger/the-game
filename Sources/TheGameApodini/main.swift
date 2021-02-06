import Apodini
import ApodiniREST
import ApodiniOpenAPI

struct TheGameWebService: WebService {
    var content: some Component {
        PlayerComponent()
        GameComponent()
    }

    var configuration: Configuration {
        HTTPConfiguration().address(.hostname("0.0.0.0", port: 8080))
        OpenAPIConfiguration(
            outputFormat: .json,
            outputEndpoint: "/docs/openapi",
            swaggerUiEndpoint: "ui/swagger",
            title: "The Game - Endangered Nature Edition, built with Apodini"
            )

        ExporterConfiguration()
            .exporter(RESTInterfaceExporter.self)
            .exporter(OpenAPIInterfaceExporter.self)
    }
}

try TheGameWebService.main()
