import {BrowserModule} from '@angular/platform-browser';
import {NgModule} from '@angular/core';

import {AppRoutingModule} from './app-routing.module';
import {AppComponent} from './app.component';
import {FormsModule, ReactiveFormsModule} from '@angular/forms';
import {HttpClientModule} from '@angular/common/http';
import {BrowserAnimationsModule} from '@angular/platform-browser/animations';
import {en_US, NZ_I18N} from 'ng-zorro-antd/i18n';
import {registerLocaleData} from '@angular/common';
import en from '@angular/common/locales/en';
import {LandingComponent} from './pages/landing/landing.component';
import {StartComponent} from './pages/start/start.component';
import {GameComponent} from './pages/game/game.component';
import {SharedModule} from './shared/shared.module';
import {PlayerAvatarComponent} from './pages/game/player-avatar/player-avatar.component';
import { ResultModalComponent } from './pages/game/result-modal/result-modal.component';

registerLocaleData(en);

@NgModule({
    declarations: [
        AppComponent,
        LandingComponent,
        StartComponent,
        GameComponent,
        PlayerAvatarComponent,
        ResultModalComponent,
    ],
    imports: [
        BrowserModule,
        AppRoutingModule,
        FormsModule,
        ReactiveFormsModule,
        HttpClientModule,
        BrowserAnimationsModule,
        SharedModule,
    ],
    providers: [{provide: NZ_I18N, useValue: en_US}],
    bootstrap: [AppComponent]
})
export class AppModule {
}
