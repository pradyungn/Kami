import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';

import * as firebase from 'firebase/app';
import 'firebase/auth';
import 'firebase/firestore';

import { Kami$Note } from '../shared/schemas/note.schema';

@Component({
  selector: 'app-note',
  templateUrl: './note.component.html',
  styleUrls: ['./note.component.scss']
})
export class NoteComponent implements OnInit {
  note: Kami$Note;

  constructor(private router: Router,
              private route: ActivatedRoute) { }

  ngOnInit(): void {
    let id = this.route.snapshot.paramMap.get("id");
    console.log(id);

    var db = firebase.firestore();
    db.collection(firebase.auth().currentUser.uid).doc(id).get().then(data => this.note = <Kami$Note><unknown>data.data());
  }

}
