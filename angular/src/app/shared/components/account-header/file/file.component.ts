import { Component, OnInit, Input, Output, EventEmitter } from '@angular/core';

import { APIService } from '../../../../core/services/';

import * as firebase from 'firebase/app';
import 'firebase/auth';
import 'firebase/firestore';

@Component({
  selector: 'dialog-createfrom-file',
  templateUrl: './file.component.html',
  styleUrls: ['./file.component.scss']
})
export class FileComponent implements OnInit {
  @Input() shown: boolean;
  @Output() closeEvent = new EventEmitter();

  title: string = "";

  constructor(private api: APIService) { }

  ngOnInit(): void {
  }

  async submitImage() {
    let input = <HTMLInputElement>document.getElementById("file");
    let outtext: string[] = [];

    const files = Array.from(input.files);

    const res = await Promise.all(files.map(async (file) => {
      outtext.push(await this.api.getOCR(await file.arrayBuffer()));
    }));

    this.getNLP(outtext.join(' '));
  }

  private getNLP(text: string): void {
    this.api.getNLP(text, (output) => {
      var db = firebase.firestore();
      db.collection(firebase.auth().currentUser.uid).add({
        "title": this.title,
        "text": text,
        "summary": output
      });

      this.closeDialog();
    });
  }

  closeDialog(): void {
    this.closeEvent.emit();
  }

  stopPropagation(event: Event): void {
    event.stopPropagation();
  }
}
