import {ChangeDetectionStrategy, Component, Input, OnInit} from '@angular/core';
import {Game, Player} from '../../../shared/openapi';
import {GameService} from '../../../shared/services/game.service';

@Component({
    selector: 'app-result-modal',
    templateUrl: './result-modal.component.html',
    styleUrls: ['./result-modal.component.scss'],
    changeDetection: ChangeDetectionStrategy.OnPush
})
export class ResultModalComponent implements OnInit {

    @Input() public modalVisible: boolean;
    @Input() public game: Game;

    constructor(private gameService: GameService) {
    }

    handleCancel(): void {
        this.modalVisible = false;
    }

    ngOnInit(): void {
    }

    getPlayersWithCards(): Player[] {
        return Object.values(this.game.players).filter(player => player.hand.length > 0);
    }
}
