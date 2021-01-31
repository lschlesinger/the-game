import {NgModule} from '@angular/core';
import {RouterModule, Routes} from '@angular/router';
import {LandingComponent} from './pages/landing/landing.component';
import {StartComponent} from './pages/start/start.component';
import {GameComponent} from './pages/game/game.component';
import {SharedModule} from './shared/shared.module';
import {AuthGuard} from './shared/guards/auth.guard';
import {LoginGuard} from './shared/guards/login.guard';

const routes: Routes = [
    {path: '', component: LandingComponent, canActivate: [LoginGuard]},
    {path: 'start', component: StartComponent, canActivate: [AuthGuard]},
    {path: 'game/:id', component: GameComponent, canActivate: [AuthGuard]},
    {redirectTo: '', path: '**', pathMatch: 'full'}
];

@NgModule({
    imports: [
        RouterModule.forRoot(routes, {relativeLinkResolution: 'legacy'}),
        SharedModule
    ],
    exports: [RouterModule]
})
export class AppRoutingModule {
}
