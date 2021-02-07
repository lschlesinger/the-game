import {ChangeDetectionStrategy, Component, Input, OnInit} from '@angular/core';
import {Game, Player} from '../../../shared/openapi';

@Component({
    selector: 'app-player-avatar',
    templateUrl: './player-avatar.component.html',
    styleUrls: ['./player-avatar.component.scss'],
    changeDetection: ChangeDetectionStrategy.OnPush
})
export class PlayerAvatarComponent implements OnInit {

    @Input() public player: Player;
    @Input() public game: Game;

    constructor() {
    }

    ngOnInit(): void {
    }

}

// TODO: highlight font for current player (currently cannot be seen whose turn it is)!