import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

import * as firebase from 'firebase/app';
import 'firebase/firestore';

import { Kami$Note } from '../shared/schemas/note.schema';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss']
})
export class DashboardComponent implements OnInit {
  db: firebase.firestore.Firestore;
  notes: Kami$Note[] = [];

  constructor(private router: Router) { }

  ngOnInit(): void {
    let uid = firebase.auth().currentUser.uid;
    
    // Get user collection
    this.db = firebase.firestore();
    this.db.collection(uid).onSnapshot(qs => {
      this.notes = [];

      qs.forEach((doc) => {
        let note = <Kami$Note><unknown>doc.data();
        note.id = doc.id;
        this.notes.push(note);
      });
    });
  }
}
