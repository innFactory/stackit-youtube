import os

from stackit.objectstorage.api.default_api import DefaultApi
from stackit.core.configuration import Configuration

from stackit.objectstorage.api.default_api import CreateCredentialsGroupPayload
from stackit.objectstorage.api.default_api import CreateAccessKeyPayload
from stackit.core.configuration import Configuration
from flask import Flask

import boto3

PROJECT_ID = "ff94ba73-704a-4616-9a9d-6ac2f7d84592"
REGION = "eu01"
CREDENTIALS_GROUP_NAME = "coffee-image-group"
BUCKET_NAME = "coffee-image-bucket"

# configure flask
app = Flask(__name__)
port = int(8080)


@app.route("/<coffee_id>")
def main(coffee_id):

    try:
        # Create a new API client, that uses default authentication and configuration
        config = Configuration(
            service_account_key_path="./sa.json",
        )
        client = DefaultApi(config)

        groups = client.list_credentials_groups(PROJECT_ID, f"{REGION}")
        group = None

        for g in groups.credentials_groups:
            if g.display_name == CREDENTIALS_GROUP_NAME:
                group = g
                print(f"Found group {g.display_name}")

        if not group:
            print(f"Creating group {CREDENTIALS_GROUP_NAME}")
            g = client.create_credentials_group(
                PROJECT_ID,
                f"{REGION}",
                CreateCredentialsGroupPayload(display_name=CREDENTIALS_GROUP_NAME),
            )
            group = g.credentials_group

        key = client.create_access_key(
            PROJECT_ID,
            f"{REGION}",
            CreateAccessKeyPayload(expires="2025-05-16T00:00:00.000Z"),
            group.credentials_group_id,
        )

        # create s3 client
        s3client = boto3.client(
            "s3",
            endpoint_url="https://object.storage.eu01.onstackit.cloud",
            aws_access_key_id=key.access_key,
            aws_secret_access_key=key.secret_access_key,
        )

        # create presigned url
        presigned_request = s3client.generate_presigned_url(
            "get_object",
            Params={"Bucket": BUCKET_NAME, "Key": f"coffee-{coffee_id}.png"},
            ExpiresIn=3600,
        )
        return presigned_request, 200
    except Exception as e:
        return f"Error: {e}", 500


if __name__ == "__main__":
    # Run the app, listening on all IPs with our chosen port number
    app.run(host="0.0.0.0", port=port)
