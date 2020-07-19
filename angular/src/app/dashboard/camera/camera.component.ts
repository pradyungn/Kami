import { Component, OnInit, Input, Output, EventEmitter } from '@angular/core';

@Component({
  selector: 'dashboard-camera',
  templateUrl: './camera.component.html',
  styleUrls: ['./camera.component.scss']
})
export class CameraComponent implements OnInit {
  @Input() shown = true;
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
