# Manual: Building a Web App with Apodini and OAS

In the follwing, it is explained, how to use Apodini when building a swift web app and automatically creating the corresponding client SDK with OpenAPISpecification 3.0.
It's acutally a 10-step plan:
 
1. Create a swift project with Apodini as dependency
2. Implement game logic
3. Define Apodini handlers, i.e., endpoints of the web app
4. Compose web app using Apodini (sub-)components
5. Enrich endpoints with OAS modifiers. 
	1. Add descriptions to handlers
	2. Add tags to handlers
6. Configure web app
	1. HTTP: set URL
	2. OAS: format, OAS endpoint, Swagger-UI endpoint
7. Run Apodini backend
	1. Inspect generated OAS
	2. Explore web app via Swagger-UI
8. Run shell script to generate client SDK
9. Work on FE and finetune style, can only be a matter of weeks…
10. Start using the web app

Imagine the following example:

You want to build a web application for your favorite card game.
Certainly, we want an endpoint returning a game when given a specific identifier as path parameter, i.e., something like a “getGame” endpoint.
This example is used thoughout the following step-by-step image manual. The “getGame” endpoint is always highlighted with a red rectangle.

[next: step by step manual](./step-1.md)
