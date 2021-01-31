import {Injectable} from '@angular/core';
import {interval, Observable} from 'rxjs';
import {Action, DefaultService, Game} from '../openapi';
import {map, mergeMap, take} from 'rxjs/operators';
import {PlayerService} from './player.service';

@Injectable()
export class GameService {
    constructor(private apiService: DefaultService,
                private playerService: PlayerService) {
    }

    public createGame(name: string): Observable<Game> {
        return this.apiService.createGame(name)
            .pipe(
                map((gameResponse) => gameResponse.data)
            );
    }

    public joinGame(gameId: string): Observable<Game> {
        return this.playerService.player
            .pipe(
                take(1),
                mergeMap((player) => this.apiService.joinGame(gameId, player.id)),
                map((gameResponse) => gameResponse.data)
            );
    }

    public passGame(gameId: string): Observable<Game> {
        return this.apiService.passGame(gameId)
            .pipe(
                map((gameResponse) => gameResponse.data)
            );
    }

    public startGame(gameId: string): Observable<Game> {
        return this.apiService.startGame(gameId)
            .pipe(
                map((gameResponse) => gameResponse.data)
            );
    }

    public playAction(gameId: string, action: Action): Observable<Game> {
        return this.apiService.playGame(gameId, action)
            .pipe(
                map((gameResponse) => gameResponse.data)
            );
    }

    public getGame(gameId: string): Observable<Game> {
        return interval(1000)
            .pipe(
                mergeMap(() => this.apiService.getGame(gameId)),
                map((gameResponse) => gameResponse.data)
            );
    }

    public getGames(): Observable<Game[]> {
        return this.apiService.getGames()
            .pipe(
                map((dictionaryOfGames) => Object.values(dictionaryOfGames.data))
            );
    }
}
