import { Component, OnInit, Input, Output, EventEmitter } from '@angular/core';

@Component({
  selector: 'dialog-createfrom-file',
  templateUrl: './file.component.html',
  styleUrls: ['./file.component.scss']
})
export class FileComponent implements OnInit {
  @Input() shown: boolean;
  @Output() closeEvent = new EventEmitter();

  constructor() { }

  ngOnInit(): void {
  }

  closeDialog() {
    this.closeEvent.emit();
  }

  stopPropagation(event: Event) {
    event.stopPropagation();
  }
}
