import {Component, OnDestroy, OnInit} from '@angular/core';
import {ActivatedRoute} from '@angular/router';
import {GameService} from '../../shared/services/game.service';
import {Subscription} from 'rxjs';
import {Action, Card, Game, GamePile, Player} from '../../shared/openapi';
import {PlayerService} from '../../shared/services/player.service';
import {NzMessageService} from 'ng-zorro-antd/message';

@Component({
    selector: 'app-game',
    templateUrl: './game.component.html',
    styleUrls: ['./game.component.scss']
})
export class GameComponent implements OnInit, OnDestroy {

    gameId: string;
    game: Game;
    player: Player;
    players: Player[];
    currentAction: Action;
    prevState: string;
    modalVisible: boolean;
    showHistory = false;

    private routeSub: Subscription;
    private gameSub: Subscription;
    private playerSub: Subscription;


    constructor(
        private route: ActivatedRoute,
        private gameService: GameService,
        private playerService: PlayerService,
        private message: NzMessageService,
    ) {
    }

    ngOnInit(): void {
        this.playerSub = this.playerService.player
            .subscribe((player) => {
                this.player = player;
            });
        this.routeSub = this.route.params
            .subscribe((params) => {
                this.gameId = params.id;
                this.getGame();
            });
    }

    ngOnDestroy(): void {
        this.routeSub.unsubscribe();
        this.gameSub.unsubscribe();
        this.playerSub.unsubscribe();
    }

    getPiles(order: string = 'asc'): GamePile[] {
        return this.game.gamePiles.filter((pile) => pile.order === order);
    }

    getHand(): Card[] {
        return this.game.players[this.player.id].hand;
    }

    startGame(): void {
        this.gameService.startGame(this.gameId)
            .subscribe((game) => {
                this.message.success('Game has started!');
            }, (err) => {
                this.message.error('Missing players to start game.');
            });

    }

    selectCardForAction(card: Card): void {
        console.log(card);
        if (this.checkForPlayersTurn()) {
            this.currentAction = {
                gamePileId: null,
                playerId: this.player.id,
                card
            };
        } else {
            this.message.info('Wait until it is your turn!');
        }
    }

    selectPileForAction(pile: GamePile): void {
        if (this.checkForPlayersTurn()) {
            if (!this.currentAction || !this.currentAction?.card) {
                this.message.info('Please select a card first.');
                return;
            }
            this.currentAction = {
                ...this.currentAction,
                gamePileId: pile.id
            };
            this.gameService.playAction(this.gameId, this.currentAction)
                .subscribe((game) => {
                    },
                    (error => {
                        this.message.warning(error.error.reason);
                    }));
        } else {
            this.message.info('Wait until it is your turn!');
        }
    }

    checkForPlayersTurn(): boolean {
        return this.game.currentPlayerId === this.player.id;
    }

    passAction(): void {
        this.gameService.passGame(this.gameId)
            .subscribe(() => {
                    this.resetCurrentAction();
                },
                (error => {
                    console.log(error);
                    this.message.warning(error.error.reason);
                }));
    }

    getPlayers(): Player[] {
        this.players = [];
        if (this.game.players) {
            this.players = [...Object.values(this.game.players)];
        }
        return this.players.sort((a, b) => a.id.localeCompare(b.id));
    }

    trackByPlayerFn(i: number, player: Player): string {
        return player.id;
    }

    getPileHistory(pileId: string): Card[] {
        const pileCards = this.game.gamePiles.find((pile) => pile.id === pileId).stack.storage;
        const pileSize = pileCards.length;
        const pileLastIndex = pileSize - 1;
        return pileCards.slice(pileLastIndex - (Math.min(pileSize - 1, 2)), pileSize);
    }

    private getGame(): void {
        this.gameSub = this.gameService.getGame(this.gameId)
            .subscribe((game) => {
                this.prevState = this.game?.status;
                this.game = game;
                if (this.game.status === 'closed' && this.prevState !== this.game.status) {
                    this.modalVisible = true;
                }
            });
    }

    private resetCurrentAction(): void {
        this.currentAction = {
            gamePileId: null,
            card: null,
            playerId: this.player.id
        };
    }
}
