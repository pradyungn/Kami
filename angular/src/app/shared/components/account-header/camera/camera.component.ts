import { Component, Input, Output, EventEmitter } from '@angular/core';

@Component({
  selector: 'dashboard-camera',
  templateUrl: './camera.component.html',
  styleUrls: ['./camera.component.scss']
})
export class CameraComponent {
  @Input() shown: boolean;
  @Output() closeEvent = new EventEmitter();

  video: HTMLVideoElement;

  constructor() { }

  async initVideo() {
    this.video = <HTMLVideoElement>document.getElementById("video");
    
    const constraints = {
        video: {
            width: 640, height: 480
        }
    };

    const stream = await navigator.mediaDevices.getUserMedia(constraints);
    this.video.srcObject = stream;
  }

  closeDialog() {
    this.closeEvent.emit();
  }

  stopPropagation(event: Event) {
    event.stopPropagation();
  }
}
