import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';

import { MatDialog } from '@angular/material/dialog';
import { DeleteComponent } from './delete/delete.component';

import * as firebase from 'firebase/app';
import 'firebase/auth';
import 'firebase/firestore';

import { Kami$Note } from '../shared/schemas/note.schema';
import { APIService } from 'app/core/services';

@Component({
  selector: 'app-note',
  templateUrl: './note.component.html',
  styleUrls: ['./note.component.scss']
})
export class NoteComponent implements OnInit {
  db: firebase.firestore.Firestore;
  note: Kami$Note;
  noteId: string;

  constructor(private router: Router,
              private route: ActivatedRoute,
              private dialog: MatDialog,
              private api: APIService) { }

  ngOnInit(): void {
    let id = this.route.snapshot.paramMap.get("id");
    this.noteId = id;

    this.db = firebase.firestore();
    this.db.collection(firebase.auth().currentUser.uid).doc(id).onSnapshot(data => {
      this.note = <Kami$Note><unknown>data.data(); 
    });
  }

  generateSummary() {
    this.api.getNLP(this.note.text, (output) => {
      this.db.collection(firebase.auth().currentUser.uid).doc(this.noteId).update({
        "title": this.note.title,
        "text": this.note.text,
        "summary": output
      });
    });
  }

  openDeleteDialog(): void {
    const ref = this.dialog.open(DeleteComponent);

    ref.afterClosed().subscribe(result => {
      if (result) {
        this.db.collection(firebase.auth().currentUser.uid).doc(this.noteId).delete();
        this.router.navigateByUrl("/dashboard");
      }
    });
  }
}
