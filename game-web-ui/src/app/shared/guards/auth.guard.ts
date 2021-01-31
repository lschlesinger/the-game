import {Injectable} from '@angular/core';
import {ActivatedRouteSnapshot, CanActivate, Router, RouterStateSnapshot} from '@angular/router';
import {Observable} from 'rxjs';
import {PlayerService} from '../services/player.service';
import {map} from 'rxjs/operators';

@Injectable()
export class AuthGuard implements CanActivate {
    constructor(private router: Router,
                private playerService: PlayerService) {
    }

    canActivate(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): boolean | Observable<boolean> {
        return this.playerService.player
            .pipe(
                map((player) => {
                        if (!!player) {
                            return true;
                        }
                        this.router.navigateByUrl('/');
                        return false;
                    }
                )
            );
    }
}
