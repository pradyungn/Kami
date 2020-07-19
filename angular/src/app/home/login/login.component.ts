import { Component, OnInit, Input } from '@angular/core';

@Component({
  selector: 'home-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent implements OnInit {
  @Input() action: string;

  constructor() { }

  ngOnInit(): void {
  }

  clickRouter() {
    
  }
}
