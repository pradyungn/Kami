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
  notes: Kami$Note[] = [];

  constructor(private router: Router) { }

  ngOnInit(): void {
    // Get user collection
    var db = firebase.firestore();
    db.collection(firebase.auth().currentUser.uid).get().then(qs => {
      qs.forEach((doc) => {
        let note = <Kami$Note><unknown>doc.data();
        note.id = doc.id;
        this.notes.push(note);
      });
    });
  }
}
