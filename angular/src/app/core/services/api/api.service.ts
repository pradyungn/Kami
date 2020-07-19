import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class APIService {

  constructor() { }

  // long text -> callback(summary text)
  getNLP(input: string, callback: (output: string) => void) {
    var xhr = new XMLHttpRequest();

    xhr.onload = () => {
      // process response
      if (xhr.status == 200)
        callback(JSON.parse(xhr.response).output);
      else
        console.error('Error!');
    };

    xhr.open("POST", "api.kamiapp.ml/nlp", true);
    xhr.setRequestHeader("Content-type", "application/json");
    xhr.send(`{"input": "${input}"}`);
  }

  // base64 image -> callback(long text)
  getOCR(input: string, callback: (output: string) => void) {
    var xhr = new XMLHttpRequest();

    xhr.onload = () => {
      // process response
      if (xhr.status == 200)
        callback(JSON.parse(xhr.response).output);
      else
        console.error('Error!');
    };

    xhr.open("POST", "api.kamiapp.ml/ocr", true);
    xhr.setRequestHeader("Content-type", "application/json");
    xhr.send(`{"input": "${input}"}`);
  }
}
