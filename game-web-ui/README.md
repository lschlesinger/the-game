# GameWebUi

This project was generated with [Angular CLI](https://github.com/angular/angular-cli) version 10.1.7.

## Generate Typescript OpenAPI client SDK for Angular

```shell
brew install swagger-codegen
swagger-codegen generate -i ./openapi.json -l typescript-angular -o ./src/app/shared/openapi --additional-properties ngVersion=11.1.0
sed -i '' 's/: ModuleWithProviders/: ModuleWithProviders\<ApiModule\>/g' src/app/shared/openapi/api.module.ts
sed -i '' 's/http\:\/\/127.0.0.1\:8080//g' src/app/shared/openapi/api/default.service.ts
```

## Development server

Run `ng serve` for a dev server. Navigate to `http://localhost:4200/`. The app will automatically reload if you change any of the source files.

## Code scaffolding

Run `ng generate component component-name` to generate a new component. You can also use `ng generate directive|pipe|service|class|guard|interface|enum|module`.

## Build

Run `ng build` to build the project. The build artifacts will be stored in the `dist/` directory. Use the `--prod` flag for a production build.

## Running unit tests

Run `ng test` to execute the unit tests via [Karma](https://karma-runner.github.io).

## Running end-to-end tests

Run `ng e2e` to execute the end-to-end tests via [Protractor](http://www.protractortest.org/).

## Further help

To get more help on the Angular CLI use `ng help` or go check out the [Angular CLI README](https://github.com/angular/angular-cli/blob/master/README.md).
