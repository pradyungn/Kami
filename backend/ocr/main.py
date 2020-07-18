#!/usr/bin/env python3
from flask import Flask
from PIL import Image
import pytesseract as pyocr
import io
from flask import request
app = Flask(__name__)

@app.route("/ocr", methods = ['POST','GET'])
def ocr():
    encode_png = request.args.get("encode", type = str)
    return(pyocr.image_to_string(Image.open(io.BytesIO(str.decode('base64')))))



