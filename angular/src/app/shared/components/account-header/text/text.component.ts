import { Component, OnInit, Input, Output, EventEmitter } from '@angular/core';

import { APIService } from '../../../../core/services/';

import * as firebase from 'firebase/app';
import 'firebase/auth';
import 'firebase/firestore';

@Component({
  selector: 'dialog-createfrom-text',
  templateUrl: './text.component.html',
  styleUrls: ['./text.component.scss']
})
export class TextComponent implements OnInit {
  @Input() shown: boolean;
  @Output() closeEvent = new EventEmitter();

  title: string = "";
  text: string = "";

  constructor(private api: APIService) { }

  ngOnInit(): void {
  }

  submitText(): void {
    this.api.getNLP(this.text, (output) => {
      var db = firebase.firestore();
      db.collection(firebase.auth().currentUser.uid).add({
        "title": this.title,
        "text": this.text,
        "summary": output
      });

      this.closeDialog();
    });
  }

  closeDialog() {
    this.closeEvent.emit();
  }

  stopPropagation(event: Event) {
    event.stopPropagation();
  }
}
