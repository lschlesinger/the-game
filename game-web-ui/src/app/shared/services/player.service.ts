import {Injectable} from '@angular/core';
import {Observable, ReplaySubject} from 'rxjs';
import {ApiPlayerService, Player} from '../openapi';
import {map} from 'rxjs/operators';

const PLAYER_KEY = 'the-game-player';

@Injectable()
export class PlayerService {

    private player$: ReplaySubject<Player> = new ReplaySubject<Player>(1);

    constructor(private apiPlayerService: ApiPlayerService) {
        this.getPlayerFromStorage();
    }

    public get player(): Observable<Player> {
        return this.player$;
    }

    public createPlayer(name: string): Observable<Player> {
        return this.apiPlayerService.createPlayer(name)
            .pipe(
                map((playerResponse) => {
                    this.setPlayerInStorage(playerResponse.data);
                    return playerResponse.data;
                }));
    }

    logout(): void {
        localStorage.removeItem(PLAYER_KEY);
        this.getPlayerFromStorage();
    }

    private getPlayerFromStorage(): void {
        const value: string = localStorage.getItem(PLAYER_KEY);
        console.log(value);
        if (value) {
            this.player$.next(JSON.parse(value));
        } else {
            this.player$.next(null);
        }
    }

    private setPlayerInStorage(player: Player): void {
        localStorage.setItem(PLAYER_KEY, JSON.stringify(player));
        this.player$.next(player);
    }
}
