import {Component, OnInit} from '@angular/core';
import {FormBuilder, FormGroup, Validators} from '@angular/forms';
import {PlayerService} from '../../shared/services/player.service';
import {Router} from "@angular/router";

@Component({
    selector: 'app-landing',
    templateUrl: './landing.component.html',
    styleUrls: ['./landing.component.scss']
})
export class LandingComponent implements OnInit {

    validateForm!: FormGroup;

    constructor(private fb: FormBuilder,
                private playerService: PlayerService,
                private router: Router) {
    }

    ngOnInit(): void {
        this.validateForm = this.fb.group({
            userName: [null, [Validators.required]]
        });
    }

    submitForm(): void {
        this.playerService.createPlayer(this.validateForm.get('userName').value).subscribe(() => {
            this.router.navigateByUrl('/start');
        });

        // tslint:disable-next-line:forin
        for (const i in this.validateForm.controls) {
            this.validateForm.controls[i].markAsDirty();
            this.validateForm.controls[i].updateValueAndValidity();
        }
    }

}
