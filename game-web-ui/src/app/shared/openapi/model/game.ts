/**
 * 
 * No description provided (generated by Swagger Codegen https://github.com/swagger-api/swagger-codegen)
 *
 * OpenAPI spec version: v1
 * 
 *
 * NOTE: This class is auto generated by the swagger code generator program.
 * https://github.com/swagger-api/swagger-codegen.git
 * Do not edit the class manually.
 */
import { Action } from './action';
import { DrawPile } from './drawPile';
import { GamePile } from './gamePile';
import { Player } from './player';

export interface Game { 
    status: Game.StatusEnum;
    gamePiles: Array<GamePile>;
    result: Game.ResultEnum;
    id: string;
    currentActions: Array<Action>;
    players: { [key: string]: Player; };
    currentPlayerId?: string;
    name: string;
    drawPile: DrawPile;
}
export namespace Game {
    export type StatusEnum = 'open' | 'running' | 'closed';
    export const StatusEnum = {
        Open: 'open' as StatusEnum,
        Running: 'running' as StatusEnum,
        Closed: 'closed' as StatusEnum
    };
    export type ResultEnum = 'win' | 'lose' | 'none';
    export const ResultEnum = {
        Win: 'win' as ResultEnum,
        Lose: 'lose' as ResultEnum,
        None: 'none' as ResultEnum
    };
}