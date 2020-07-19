import base64

with open("test.jpeg", "rb") as image_file:
    print(base64.urlsafe_b64encode(image_file.read()))
