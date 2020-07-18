from PIL import Image,ImageFile
import io, base64, pytesseract
from flask import Flask, request
app = Flask(__name__)

@app.route("/ocr", methods = ['POST','GET'])
def ocr():
    encode_string = request.args.get("encoded_image", type = str) + '==='
    decode_string = base64.urlsafe_b64decode(encode_string)
    image = Image.open(io.BytesIO(decode_string))
    image.show()
    return(pytesseract.image_to_string(image))
