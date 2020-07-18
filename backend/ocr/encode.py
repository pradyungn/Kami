import base64
with open("test.png", "rb") as f:
  print(base64.urlsafe_b64encode(f.read()).decode("ascii"))
