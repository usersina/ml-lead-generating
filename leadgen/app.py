from flask import Flask

from .routes import bp


def create_app():
    """
    Create a Flask app and register the blueprint.
    """

    app = Flask(__name__)
    app.register_blueprint(bp)
    return app
