import { Component, OnInit, Input, Output, EventEmitter } from '@angular/core';

@Component({
  selector: 'dialog-createfrom-text',
  templateUrl: './text.component.html',
  styleUrls: ['./text.component.scss']
})
export class TextComponent implements OnInit {
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
