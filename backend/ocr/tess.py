import pytesseract
from PIL import Image,ImageFile
import io, base64
encode_string = input() + '==='
decode_string = base64.urlsafe_b64decode(encode_string)
image = Image.open(io.BytesIO(decode_string))
image.show()
print(pytesseract.image_to_string(image))
