from flask import Flask

from rutas import rutas

app = Flask(__name__)
app.json.ensure_ascii = False
app.register_blueprint(rutas)

if __name__ == "__main__":
    app.run(debug=True)