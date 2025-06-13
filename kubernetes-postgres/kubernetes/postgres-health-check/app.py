from flask import Flask, jsonify
import psycopg2
import os

app = Flask(__name__)


def check_postgres_connection():
    try:
        connection = psycopg2.connect(
            dbname=os.getenv("POSTGRES_DB"),
            user=os.getenv("POSTGRES_USER"),
            password=os.getenv("POSTGRES_PASSWORD"),
            host=os.getenv("POSTGRES_HOST"),
            port=os.getenv("POSTGRES_PORT", "5432"),
        )
        connection.close()
        return True
    except Exception as e:
        print(f"Connection failed: {e}")
        return False


@app.route("/health", methods=["GET"])
def health_check():
    if check_postgres_connection():
        return jsonify(status="ok"), 200
    else:
        return jsonify(status="fail"), 500


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=55555)
