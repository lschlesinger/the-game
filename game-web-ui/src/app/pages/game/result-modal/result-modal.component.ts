import {ChangeDetectionStrategy, Component, Input, OnInit} from '@angular/core';
import {Game, Player} from '../../../shared/openapi';

@Component({
    selector: 'app-result-modal',
    templateUrl: './result-modal.component.html',
    styleUrls: ['./result-modal.component.scss'],
    changeDetection: ChangeDetectionStrategy.OnPush
})
export class ResultModalComponent implements OnInit {

    @Input() public modalVisible: boolean;
    @Input() public game: Game;

    constructor() {
    }

    handleOk(): void {
        console.log('Button ok clicked!');
        this.modalVisible = false;
        // reset game.
    }

    handleCancel(): void {
        console.log('Button cancel clicked!');
        this.modalVisible = false;
    }

    ngOnInit(): void {
    }

    getPlayersWithCards(): Player[] {
        return Object.values(this.game.players).filter(player => player.hand.length > 0);
    }

}
