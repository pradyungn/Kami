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

    xhr.open("POST", "https://api.kamiapp.ml/nlp", true);
    xhr.setRequestHeader("Content-type", "application/json");
    xhr.send(`{"input": "${input}"}`);
  }

  // image bytes -> callback(long text)
  async getOCR(input: ArrayBuffer): Promise<string> {
    return new Promise(function (resolve, reject) {
      let xhr = new XMLHttpRequest();
      xhr.open("POST", "https://api.kamiapp.ml/ocr", true);

      xhr.onload = () => {
        if (this.status === 200) {
          resolve(JSON.parse(xhr.response).output);
        } else {
          reject({
            status: this.status,
            statusText: `Unexpected: ${xhr.statusText}`
          });
        }
      };

      xhr.send(`${input}`);
  });
  }
}
