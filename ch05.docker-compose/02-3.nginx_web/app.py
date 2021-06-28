from flask import Flask
app = Flask(__name__)
@app.route('/greeting')
def greeting():
    return 'This is the demo for nginx + wep with docker-compose!!!'
if __name__ == '__main__':
    app.run('0.0.0.0', debug=True)