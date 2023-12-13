'''
Basic static web app
Use for exercises that don't need a database layer
'''
from flask import Flask
from os import getenv

app = Flask(__name__)

@app.route('/')
def home():
    hostname = getenv('HOSTNAME')
    name = getenv('YOUR_NAME')
    if name is None:
      name = "No Name Selected"
    return f"<h1>Hello {name}.</h1>\n\n<h2>I'm currently running in {hostname}.</h2>\n<h2>Good2Bye {name}.</h2\n<h3>Good Bye {name}.</h3>"
if __name__=='__main__':
  app.run(host='0.0.0.0', port=5500, debug=True)

