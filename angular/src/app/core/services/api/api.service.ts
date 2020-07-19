import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class APIService {

  constructor() { }

  // long text -> callback(summary text)
  getNLP(input: string, callback: (output: string) => void) {
    fetch("https://api.kamiapp.ml/nlp", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      mode: "cors",
      body: JSON.stringify({
        "input": input,
      })
    })
      .then(response => response.text())
      .then(response => {
        callback(JSON.parse(response).output);
      })
      .catch(err => console.error(err));
  }

  // image bytes -> callback(long text)
  async getOCR(input: ArrayBuffer): Promise<string> {
    return new Promise(function (resolve, reject) {
      fetch("https://api.kamiapp.ml/ocr", {
        method: "POST",
        mode: "cors",
        body: input
      })
        .then(response => response.text())
        .then(response => {
          resolve(JSON.parse(response).output);
        })
        .catch(err => reject(err));
  });
  }
}
