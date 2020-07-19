import cv2 as cv
import pytesseract
import numpy
from PIL import Image
image = Image.open('test.jpeg').convert('RGB')
image = cv.cvtColor(numpy.array(image), cv.COLOR_RGB2BGR)
image = cv.resize(image, None, fx=1.2, fy=1.2, interpolation=cv.INTER_CUBIC)
image = cv.cvtColor(image, cv.COLOR_BGR2GRAY)
image = cv.adaptiveThreshold(image, 255, cv.ADAPTIVE_THRESH_GAUSSIAN_C, cv.THRESH_BINARY, 31, 2)
image = cv.bilateralFilter(image,9,75,75)
text = pytesseract.image_to_string(image)
print(text)
