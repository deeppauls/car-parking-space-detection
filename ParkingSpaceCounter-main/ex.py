from flask import Flask, request, jsonify


def create_flask_app():
    app = Flask(__name__)

    @app.route("/")
    def findSpaceCounter():
        f = open("demofile.txt", "r")
        count = f.read()
        result = {
            "spaces": count
        }
        return jsonify(result), 200

    # return app

if __name__ == "__main__":
    flask_app = create_flask_app()
    flask_app.run(debug=True)
