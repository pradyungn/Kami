import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

import * as firebase from 'firebase/app';
import 'firebase/auth';

@Component({
  selector: 'app-account-header',
  templateUrl: './account-header.component.html',
  styleUrls: ['./account-header.component.scss']
})
export class AccountHeaderComponent implements OnInit {
  showFileDialog = false;
  showTextDialog = false;

  constructor(private router: Router) { }

  ngOnInit(): void {
  }

  showFile() {
    this.showFileDialog = true;
  }

  showText() {
    this.showTextDialog = true;
  }

  hideDialogs() {
    this.showCameraDialog = false;
    this.showFileDialog = false;
    this.showTextDialog = false;
  }

  logout() {
    firebase.auth().signOut();
    this.router.navigateByUrl("/home");
  }
}
