import {NgModule} from '@angular/core';
import {NzButtonModule} from 'ng-zorro-antd/button';
import {NzFormModule} from 'ng-zorro-antd/form';
import {PlayerService} from './services/player.service';
import {ApiModule} from "./openapi";
import {NzIconModule} from "ng-zorro-antd/icon";
import {NzInputModule} from "ng-zorro-antd/input";

@NgModule({
    imports: [
        NzButtonModule,
        NzFormModule,
        NzIconModule,
        NzInputModule,
        ApiModule
    ],
    exports: [
        NzButtonModule,
        NzFormModule,
        NzInputModule,
        NzIconModule,
        ApiModule
    ],
    declarations: [],
    providers: [
        PlayerService
    ],
})
export class SharedModule {
}
