import { Component, OnInit, Input } from '@angular/core';
import { Router } from '@angular/router';

import * as firebase from 'firebase/app';
import 'firebase/auth';
import 'firebase/firestore';

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

  ssoGoogle() {
    var provider = new firebase.auth.GoogleAuthProvider();
    
    firebase.auth().signInWithPopup(provider).then((result) => {
      var credential = result.credential;
      
      firebase.auth().signInWithCredential(credential).then(() => {
        this.router.navigateByUrl("/dashboard");
      });
    }).catch(function(error) {
      console.error(error.code);
      console.error(error.message);
    });
  }

  // "Routes" the click action to either register or sign in
  clickRouter() {
    let email = (<HTMLInputElement>document.getElementById(`${this.prefix}email`)).value;
    let pswd = (<HTMLInputElement>document.getElementById(`${this.prefix}pswd`)).value;

    let rpswd = "";

    firebase.auth().setPersistence(firebase.auth.Auth.Persistence.LOCAL);

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

      // Init user collection
      var db = firebase.firestore();
      db.collection(firebase.auth().currentUser.uid).add({
        "text": "This is your first text file!",
        "title": "Your First Text",
        "summary": "This is the text file's summary."
      });

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
