import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-account-header',
  templateUrl: './account-header.component.html',
  styleUrls: ['./account-header.component.scss']
})
export class AccountHeaderComponent implements OnInit {
  showCameraDialog = false;
  showFileDialog = false;
  showTextDialog = false;

  constructor() { }

  ngOnInit(): void {
  }

  showCamera() {
    this.showCameraDialog = true;
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
}
