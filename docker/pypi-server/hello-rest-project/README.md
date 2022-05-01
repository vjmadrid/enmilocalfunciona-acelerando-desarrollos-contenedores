# hello-rest-project

docker build -t acme/hello-rest-project .



http://localhost:5000/

curl http://localhost:5000

## Execute Dockerfile01

docker build -t acme/hello-rest-project -f Dockerfile01 .
docker run -p 5000:5000 acme/hello-rest-project

## Execute Dockerfile02

docker build -t acme/hello-rest-project-slim -f Dockerfile02 .
docker run -p 5000:5000 acme/hello-rest-project-slim