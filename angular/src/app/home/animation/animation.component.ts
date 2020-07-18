import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'home-animation',
  templateUrl: './animation.component.html',
  styleUrls: ['./animation.component.scss']
})
export class AnimationComponent implements OnInit {

  constructor() { }

  ngOnInit(): void {
    // Absolute non-apologetic jank
    setTimeout(() => {
      var button = document.getElementById("animation-compress-button");

      document.getElementById("animation-progress-bar").style.opacity = "1";
      document.getElementById("animation-content").style.opacity = "0";

      button.style.backgroundColor = "var(--dark-blue)";
      button.style.color = "var(--white)";

      setTimeout(() => {
        document.getElementById("animation-progress-bar").style.opacity = "0";
        button.style.backgroundColor = "";
        button.innerText = "Done!"

        document.getElementById("animation-content").style.display = "none";
        document.getElementById("animation-end").style.display = "flex";
        
      }, 2000);
    }, 2500);
  }

}
