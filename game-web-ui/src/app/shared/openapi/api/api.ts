export * from './apiAction.service';
import { ApiActionService } from './apiAction.service';
export * from './apiGame.service';
import { ApiGameService } from './apiGame.service';
export * from './apiPlayer.service';
import { ApiPlayerService } from './apiPlayer.service';
export const APIS = [ApiActionService, ApiGameService, ApiPlayerService];
