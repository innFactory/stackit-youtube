# Dockerfile

FROM python:3.9-slim

# Set environment variables for Flask app
ENV FLASK_APP=app.py

# Set working directory
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . .

# Install the necessary dependencies
RUN pip install Flask psycopg2-binary

# Make the container listen on port 5000
EXPOSE 5000

# Run the application
CMD ["flask", "run", "--host=0.0.0.0", "--port=5555"]

