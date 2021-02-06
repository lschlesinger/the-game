import {Injectable} from '@angular/core';
import {interval, Observable} from 'rxjs';
import {Action, ApiActionService, ApiGameService, Game} from '../openapi';
import {map, mergeMap, take} from 'rxjs/operators';
import {PlayerService} from './player.service';

@Injectable()
export class GameService {
    constructor(private apiGameService: ApiGameService,
                private apiActionService: ApiActionService,
                private playerService: PlayerService) {
    }

    public createGame(name: string): Observable<Game> {
        return this.apiGameService.createGame(name)
            .pipe(
                map((gameResponse) => gameResponse.data)
            );
    }

    public joinGame(gameId: string): Observable<Game> {
        return this.playerService.player
            .pipe(
                take(1),
                mergeMap((player) => this.apiActionService.joinGame(gameId, player.id)),
                map((gameResponse) => gameResponse.data)
            );
    }

    public passGame(gameId: string): Observable<Game> {
        return this.apiActionService.passGame(gameId)
            .pipe(
                map((gameResponse) => gameResponse.data)
            );
    }

    public startGame(gameId: string): Observable<Game> {
        return this.apiActionService.startGame(gameId)
            .pipe(
                map((gameResponse) => gameResponse.data)
            );
    }

    public playAction(gameId: string, action: Action): Observable<Game> {
        return this.apiActionService.playGame(gameId, action)
            .pipe(
                map((gameResponse) => gameResponse.data)
            );
    }

    public getGame(gameId: string): Observable<Game> {
        return interval(1000)
            .pipe(
                mergeMap(() => this.apiGameService.getGame(gameId)),
                map((gameResponse) => gameResponse.data)
            );
    }

    public getGames(): Observable<Game[]> {
        return this.apiGameService.getGames()
            .pipe(
                map((dictionaryOfGames) => Object.values(dictionaryOfGames.data))
            );
    }
}
