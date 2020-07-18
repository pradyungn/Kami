import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss']
})
export class DashboardComponent implements OnInit {
  showCameraDialog = false;
  showFileDialog = false;

  constructor(private router: Router) { }

  ngOnInit(): void {
  }

  showCamera() {
    this.showCameraDialog = true;
  }

  showFile() {
    this.showFileDialog = true;
  }

  hideDialogs() {
    this.showCameraDialog = false;
    this.showFileDialog = false;
  }
}
