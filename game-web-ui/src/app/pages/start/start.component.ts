import {Component, OnDestroy, OnInit} from '@angular/core';
import {Game, Player} from '../../shared/openapi';
import {GameService} from '../../shared/services/game.service';
import {FormBuilder, FormGroup, Validators} from '@angular/forms';
import {Router} from '@angular/router';
import {PlayerService} from '../../shared/services/player.service';
import {Subscription} from 'rxjs';

@Component({
    selector: 'app-start',
    templateUrl: './start.component.html',
    styleUrls: ['./start.component.scss']
})
export class StartComponent implements OnInit, OnDestroy {

    searchValue = '';
    visible = false;

    games: Game[];
    currentPlayer: Player;
    listOfDisplayData: Game[];
    validateForm!: FormGroup;
    private playerSub: Subscription;

    constructor(private fb: FormBuilder,
                private router: Router,
                private gameService: GameService,
                private playerService: PlayerService
    ) {
        this.updateGames();
        this.playerSub = this.playerService.player
            .subscribe(
                (player) => {
                    this.currentPlayer = player;
                }
            );
    }

    ngOnInit(): void {
        this.validateForm = this.fb.group({
            gameName: [null, [Validators.required]]
        });
    }

    submitForm(): void {
        this.gameService.createGame(this.validateForm.get('gameName').value)
            .subscribe((game) => {
                this.joinGame(game.id);
            });

        // tslint:disable-next-line:forin
        for (const i in this.validateForm.controls) {
            this.validateForm.controls[i].markAsDirty();
            this.validateForm.controls[i].updateValueAndValidity();
        }
    }

    reset(): void {
        this.searchValue = '';
        this.search();
    }

    search(): void {
        this.visible = false;
        this.listOfDisplayData = this.games.filter((item) => item.name.indexOf(this.searchValue) !== -1);
    }

    joinGame(gameId: string): void {
        this.gameService.joinGame(gameId)
            .subscribe((game) => {
                this.updateGames();
                this.router.navigateByUrl(`/game/${game.id}`);
            });
    }

    ngOnDestroy(): void {
        this.playerSub.unsubscribe();
    }

    logout(): void {
        this.playerService.logout();
        this.router.navigateByUrl('/');
    }

    private updateGames(): void {
        this.gameService.getGames()
            .subscribe((games) => {
                this.games = games;
                this.listOfDisplayData = [...this.games];
            });
    }
}
