import {Pipe, PipeTransform} from '@angular/core';
import {DomSanitizer, SafeResourceUrl, SafeUrl} from '@angular/platform-browser';

@Pipe({
    name: 'card'
})
export class CardPipe implements PipeTransform {


    constructor(protected sanitizer: DomSanitizer) {
    }

    transform(value: number): SafeUrl {
        const url = `/assets/images/Card${value}.png`;
        return url;
    }

}
