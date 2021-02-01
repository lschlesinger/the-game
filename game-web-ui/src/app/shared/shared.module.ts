import {NgModule} from '@angular/core';
import {NzButtonModule} from 'ng-zorro-antd/button';
import {NzFormModule} from 'ng-zorro-antd/form';
import {PlayerService} from './services/player.service';
import {ApiModule} from './openapi';
import {NzIconModule} from 'ng-zorro-antd/icon';
import {NzInputModule} from 'ng-zorro-antd/input';
import {AuthGuard} from './guards/auth.guard';
import {RouterModule} from '@angular/router';
import {LoginGuard} from './guards/login.guard';
import {NzTableModule} from 'ng-zorro-antd/table';
import {NzDropDownModule} from 'ng-zorro-antd/dropdown';
import {GameService} from './services/game.service';
import {NzDividerModule} from 'ng-zorro-antd/divider';
import {NzMessageModule} from 'ng-zorro-antd/message';
import {CardPipe} from './pipes/card.pipe';
import {NzLayoutModule} from "ng-zorro-antd/layout";
import {NzAvatarModule} from "ng-zorro-antd/avatar";
import {NzTypographyModule} from "ng-zorro-antd/typography";
import {NzBadgeModule} from "ng-zorro-antd/badge";
import {NzTagModule} from "ng-zorro-antd/tag";

@NgModule({
    imports: [
        NzButtonModule,
        NzFormModule,
        NzIconModule,
        NzInputModule,
        NzTableModule,
        NzDropDownModule,
        NzDividerModule,
        NzMessageModule,
        NzLayoutModule,
        NzAvatarModule,
        NzTypographyModule,
        NzBadgeModule,
        NzTagModule,
        ApiModule,
        RouterModule
    ],
    exports: [
        NzButtonModule,
        NzFormModule,
        NzInputModule,
        NzIconModule,
        NzTableModule,
        NzDropDownModule,
        NzDividerModule,
        NzMessageModule,
        NzLayoutModule,
        NzAvatarModule,
        NzTypographyModule,
        NzBadgeModule,
        NzTagModule,
        ApiModule,
        CardPipe
    ],
    declarations: [CardPipe],
    providers: [
        PlayerService,
        GameService,
        AuthGuard,
        LoginGuard
    ],
})
export class SharedModule {
}
