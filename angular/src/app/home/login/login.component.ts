import { Component, OnInit, Input } from '@angular/core';
import { Router } from '@angular/router';

import * as firebase from 'firebase/app';
import 'firebase/auth';

@Component({
  selector: 'home-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent implements OnInit {
  @Input() action: string;
  prefix: string;

  constructor(private router: Router) { }

  ngOnInit(): void {
    if (this.action === "Register")
      this.prefix = "r";
    else
      this.prefix = "l";
  }

  // "Routes" the click action to either register or sign in
  clickRouter() {
    let email = (<HTMLInputElement>document.getElementById(`${this.prefix}email`)).value;
    let pswd = (<HTMLInputElement>document.getElementById(`${this.prefix}pswd`)).value;

    let rpswd = "";

    if (this.action === "Register") {
      rpswd = (<HTMLInputElement>document.getElementById(`${this.prefix}rpswd`)).value;
      this.registerUser(email, pswd, rpswd);
    }
    else
      this.signInUser(email, pswd);
  }

  registerUser(email: string, pswd: string, rpswd: string) {
    if (pswd != rpswd) {
      document.getElementById(`${this.prefix}validation`).innerText = "Passwords do not match!";
      return;
    }

    firebase.auth().createUserWithEmailAndPassword(email, pswd).then(data => {
      console.log("Success: Create user");
      this.router.navigateByUrl("/dashboard");
    });
  }

  signInUser(email: string, pswd: string) {
    firebase.auth().signInWithEmailAndPassword(email, pswd).then(data => {
      console.log("Success: Sign In");
      this.router.navigateByUrl("/dashboard");
    });
  }
}
