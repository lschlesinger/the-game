
<!-- PROJECT LOGO -->
<br />

<p align="center">
  <a href="https://github.com/lschlesinger/the-game">
    <img src="game-web-ui/src/assets/images/logo.png" alt="Logo" width="500">
  </a>
  <p align="center">
    Swift implementation of the card game "The Game", by Steffen Benndorf using the <a href="https://github.com/Apodini/Apodini">Apodini Framework</a>.
    The Endangered Nature Edition is based on an environmental education concept, which aims to raise awareness of the current threats to certain species.
      </p>
    <br/>
  </p> 
</p>

<!-- TABLE OF CONTENTS -->

## Table of Contents

* [About the Project](#about-the-project)
  * [Motivation](#motivation)
  * [Technical Background](#technical-background)
  * [Built With](#built-with)
* [Getting Started](#getting-started)
* [Critical Reflection of the Software](#critical-reflection)
* [License](#license)

<!-- ABOUT THE PROJECT -->

## About the Project

The current Corona situation forces us in many cases to limit ourselves to digital contact and digital communication alone. Unfortunately, in times of physical distance and isolation, inviting a large group of people over for a fun evening with card or board games is more a memory of an earlier time than part of our current weekend plan - and we miss that! That is why we came up with the idea to implement our favorite card game as an online game. We can now play together with a group of friends and our families, spread all over the country.

Find more information about the original game [here](http://middys.nsv.de/middys/the-game/).
This is how our edition looks like:
<p align="center">
  <img src="game-web-ui/src/assets/images/game-example.png" alt="Logo" width="700">
</p>

We hope you have fun playing it! Please find acknowledgement as well as the source of the pictures used [here](Documentation/Acknowledgement.md).

### Motivation

Biodiversity is the basis for functioning ecosystems, on which we humans ourselves ultimately depend. Fortunately, the contribution of nature to a good quality of life is nowadays increasingly valued. Nevertheless, anthropogenic activities are destroying species habitats and thus fueling species extinction unabated.

The idea behind the card design is to raise awareness for [Nature’s Red List of Threatened Species](https://www.iucnredlist.org/about/background-history). 
The mere sight of the charming representatives of the vulnerable and endangered species should ideally contribute to advocating a more nature-friendly way of life.

### Technical Background

By using the [Apodini Framework](https://github.com/Apodini/Apodini), this sample project tackles the following problem:
<p align="center">
  <img src="./Documentation/info-material/Apodini-Problem-Statement.png" alt="Logo" width="600">
</p>

You can find a step-by-step manual on how to accomplish building a `GameWebService` with Apodini using OAS [here](Documentation/README.md).

### Built With

* [Apodini](https://github.com/Apodini/Apodini)
* [Swagger Codegen](https://github.com/swagger-api/swagger-codegen) using [OpenAPI Specification 3.0.3](https://swagger.io/specification/)
* [Angular](https://angular.io/)
* [Ant Design](https://ant.design/docs/react/introduce)
* [Docker](https://www.docker.com/)
* [NGINX](https://www.nginx.com/)

<!-- GETTING STARTED -->

## Getting Started

### Docker Setup

#### Requirements

* Docker
* Docker Compose
* Swagger codegen

#### Run

To get a local copy up and running follow these simple steps:

1. Clone the repo

```sh
git clone git@github.com:lschlesinger/the-game.git
```
2. Start backend and nginx which serves frontend

```sh
docker-compose up
```

3. Visit `http://localhost:80`

### Development Setup

#### Requirements

* Node.js
* npm
* Swift

#### Run

To get a local copy up and running follow these simple steps:

1. Clone the repo

```sh
git clone git@github.com:lschlesinger/the-game.git
```
2. Start backend

```sh
swift run
```
3. Start frontend (in separate terminal)

```sh
cd game-web-ui
npm install # only the first time
npm run start
```

4. Visit `http://localhost:4200` for frontend (all requests to backend will be proxied)
	1. Visit `http://localhost:8080/doc/openapi` (if not configured differently) to see the generated OpenAPI specification
	2. Visit `http://localhost:8080/ui/swagger` (if not configured differently) to explore the web app with Swagger-UI


<!-- CRITICAL REFLECTION -->

## Critical Reflection of the Software

Browsing the web, people with disabilitites often rely on assistive technologies, such as screen readers, magnification software, text readers, head pointers, and motion or eye trackers to access content. As this project does not include features to support these assistive technologies so far, the software is not barrier-free for all users. 
In the future, the accessibility of the online game should be guaranteed for all people, no matter where these people come from, what language they speak, what technology they use or what social background they have. That is why we are working to achieve these [Web Content Accessibility Guidelines (WCAG) 2.0](https://www.w3.org/TR/WCAG20/) in the long term. 

Moreover, the due to the mission that should be transported by the use of pictures, the page weight has potential for optimization. A generated [Page Weight](https://pageweight.imgix.com/) report suggests, that there are 83% potential savings in reducing image sizes. The current page weight of the online games does not only bear the risk of, slow load times, impeded performance, and potentially wasted energy. According to the digital agency [Mightybytes](https://www.mightybytes.com/blog/page-weight-budget-to-speed-up-your-site/) "this can frustrate many users, especially those on older mobile devices or in rural areas with restricted bandwidth". In the future, the online game should bring it's page weight to a minimum and thereby reducing the digital footprint.

In their blog post series [Sustainable Web Design](https://www.mightybytes.com/blog/sustainable-web-design/) Mightybytes introduce sustainable web design principles that generally focus on reducing electricity use but also cover the use of ‘green’ ingredients, such as clean energy-powered web hosting, for example.
Having in mind that web designers can make a measurable difference to decrease the carbon footprint of the Internet, we should face the challenge of making the online game adhereing to the sustainble web design principles as far as possible in the future.

<!-- LICENSE -->

## License

Distributed under the GPL-3.0 License. See `LICENSE` for more information.

## Contributors

:two_women_holding_hands: L&L Schlesinger
