import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

import * as firebase from 'firebase/app';
import 'firebase/firestore';

interface NoteItem {
  id: string;
  title: string;
  text: string;
  summary: string;
}

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss']
})
export class DashboardComponent implements OnInit {
  showCameraDialog = false;
  showFileDialog = false;

  notes: NoteItem[] = [];

  constructor(private router: Router) { }

  ngOnInit(): void {
    // Get user collection
    var db = firebase.firestore();
    db.collection(firebase.auth().currentUser.uid).get().then(qs => {
      qs.forEach((doc) => {
        let note = <NoteItem><unknown>doc.data();
        note.id = doc.id;
        this.notes.push(note);
      })
    });
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
