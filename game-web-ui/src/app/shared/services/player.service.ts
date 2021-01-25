import {Injectable} from '@angular/core';
import {BehaviorSubject, ReplaySubject} from "rxjs";
import {DefaultService, Player} from "../openapi";

@Injectable()
export class PlayerService {

    private player$: ReplaySubject<Player> = new ReplaySubject<Player>(1);

    constructor(private apiService: DefaultService) {

    }

    public createPlayer(name: string): void {
        this.apiService.pOSTCreatePlayer(name).subscribe((res) => {
            console.log('yeah', res.data);
        });
    }
}
