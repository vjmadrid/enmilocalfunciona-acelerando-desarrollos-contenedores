# Pull official base image
FROM python:3.11

# Set environment variables
ARG ENV=local

ENV ENV=${ENV} \
    # python
    PYTHONFAULTHANDLER=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONHASHSEED=random \
    # pip
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=120 \
    # app
    APP_HOME=/app \
    PYTHONPATH="src" \
    SERVER_HOST="0.0.0.0"

# Set the working directory in the container
WORKDIR $APP_HOME

# Copy the required resources
COPY src $APP_HOME/src
COPY main.py $APP_HOME/
COPY requirements.txt $APP_HOME/

# Install system dependencies
RUN apt-get update

# Upgrade dependencies
RUN pip install --upgrade pip setuptools wheel

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Make port 80 available to the world outside this container
EXPOSE 80

# Run app.py when the container launches
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]