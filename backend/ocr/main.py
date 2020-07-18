#!/usr/bin/env python3
from flask import Flask
from PIL import Image, ImageFile
import pytesseract as pyocr
import io
from flask import request
import base64
ImageFile.LOAD_TRUNCATED_IMAGES = True
app = Flask(__name__)

@app.route("/ocr", methods = ['POST','GET'])
def ocr():
    encode_png = request.args.get("encode", type = str)
    encode_string = base64.b64decode(encode_png)
    #return(encode_string)
    image = Image.open(io.BytesIO(encode_string))
    image.show()
    return(pyocr.image_to_string(Image.open(io.BytesIO(encode_string))))



