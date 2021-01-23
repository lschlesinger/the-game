import {BrowserModule} from '@angular/platform-browser';
import {NgModule} from '@angular/core';

import {AppRoutingModule} from './app-routing.module';
import {AppComponent} from './app.component';
import {FormsModule} from '@angular/forms';
import {HttpClientModule} from '@angular/common/http';
import {BrowserAnimationsModule} from '@angular/platform-browser/animations';
import {NZ_I18N} from 'ng-zorro-antd/i18n';
import {en_US} from 'ng-zorro-antd/i18n';
import {registerLocaleData} from '@angular/common';
import en from '@angular/common/locales/en';
import {LandingComponent} from './pages/landing/landing.component';
import {StartComponent} from './pages/start/start.component';
import {GameComponent} from './pages/game/game.component';
import {NzButtonModule} from "ng-zorro-antd/button";

registerLocaleData(en);

@NgModule({
    declarations: [
        AppComponent,
        LandingComponent,
        StartComponent,
        GameComponent
    ],
    imports: [
        BrowserModule,
        AppRoutingModule,
        FormsModule,
        HttpClientModule,
        BrowserAnimationsModule,
        NzButtonModule
    ],
    providers: [{provide: NZ_I18N, useValue: en_US}],
    bootstrap: [AppComponent]
})
export class AppModule {
}
