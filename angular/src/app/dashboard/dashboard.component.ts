import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

interface NoteItem {
  name: string;
}

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss']
})
export class DashboardComponent implements OnInit {
  showCameraDialog = false;
  showFileDialog = false;

  notes: NoteItem[];

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
