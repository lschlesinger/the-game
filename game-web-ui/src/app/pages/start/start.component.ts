import {Component, OnInit} from '@angular/core';
import {Game} from '../../shared/openapi';
import {GameService} from '../../shared/services/game.service';
import {FormBuilder, FormGroup, Validators} from '@angular/forms';
import {Router} from '@angular/router';

@Component({
    selector: 'app-start',
    templateUrl: './start.component.html',
    styleUrls: ['./start.component.scss']
})
export class StartComponent implements OnInit {

    searchValue = '';
    visible = false;

    games: Game[];

    listOfDisplayData: Game[];
    validateForm!: FormGroup;

    constructor(private fb: FormBuilder,
                private router: Router,
                private gameService: GameService) {
        this.validateForm = this.fb.group({
            gameName: [null, [Validators.required]]
        });
        this.updateGames();
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

    private updateGames(): void {
        this.gameService.getGames()
            .subscribe((games) => {
                this.games = games;
                this.listOfDisplayData = [...this.games];
            });
    }
}
