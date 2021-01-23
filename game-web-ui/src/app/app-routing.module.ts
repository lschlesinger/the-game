import {NgModule} from '@angular/core';
import {Routes, RouterModule} from '@angular/router';
import {LandingComponent} from './pages/landing/landing.component';
import {StartComponent} from './pages/start/start.component';
import {GameComponent} from './pages/game/game.component';

const routes: Routes = [
    {path: '', component: LandingComponent},
    {path: 'start', component: StartComponent},
    {path: 'game', component: GameComponent}
];

@NgModule({
    imports: [RouterModule.forRoot(routes, {relativeLinkResolution: 'legacy'})],
    exports: [RouterModule]
})
export class AppRoutingModule {
}
