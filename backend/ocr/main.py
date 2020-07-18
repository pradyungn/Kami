#!/usr/bin/env python3
<<<<<<< HEAD
=======
from flask import Flask
from PIL import Image
import pytesseract as pyocr
import io
from flask import request
import base64
app = Flask(__name__)

@app.route("/ocr", methods = ['POST','GET'])
def ocr():
    encode_png = request.args.get("encode", type = str)
    encode_string = base64.b64decode(encode_png)
    #return(encode_string)
    return(pyocr.image_to_string(Image.open(io.BytesIO(encode_string))))



>>>>>>> bb5eb23c3bac294b0e61d19ef8196bdfbc06567f
