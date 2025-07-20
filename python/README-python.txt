COMPARING PYTHON IMAGES SIZING
docker images | grep -E 'TAG|python'
REPOSITORY                         TAG       IMAGE ID       CREATED             SIZE
ubuntulatest-python3               python    e4dbbc9dacd7   About an hour ago   195MB
python311                          python    1ba2e801a521   6 weeks ago         1.02GB
python312                          python    085050585116   6 weeks ago         1.02GB
python-311-slim                    python    81760f92e061   6 weeks ago         156MB
python-312-slim                    python    8318e8e7726a   6 weeks ago         150MB
python-311-alpine                  python    647af4e21bcb   6 weeks ago         58.6MB
python-312-alpine                  python    12249791d37d   6 weeks ago         52.9MB


--
Ubuntu with Python3
docker build -f ubuntulatest-python3-Dockerfile . -t ubuntulatest-python3:python

docker images | grep -E 'TAG|python'                                            
REPOSITORY                         TAG       IMAGE ID       CREATED          SIZE
ubuntulatest-python3               python    e4dbbc9dacd7   6 minutes ago    195MB

docker run ubuntulatest-python3:python 
Python 3.12.3

--
PYTHON 3.11 DIRECTLY
docker build -f python-3.11-Dockerfile . -t python311:python -D

docker images | grep -E 'TAG|python311'                                                                                    
REPOSITORY                         TAG       IMAGE ID       CREATED          SIZE
python311                          python    1ba2e801a521   6 weeks ago      1.02GB

docker run python311:python
Python 3.11.13

--
PYTHON 3.11 SLIM
docker build -f python-3.11-slim-Dockerfile . -t python-311-slim:python -D

docker images | grep -E 'TAG|python-311-slim'                                      
REPOSITORY                         TAG       IMAGE ID       CREATED             SIZE
python-311-slim                    python    81760f92e061   6 weeks ago         156MB

docker run python-311-slim:python
Python 3.11.13

--
PYTHON 3.11 ALPINE
docker build -f python-3.11-alpine-Dockerfile . -t python-311-alpine:python -D

docker images | grep -E 'TAG|python-311-alpine'                                          
REPOSITORY                         TAG       IMAGE ID       CREATED             SIZE
python-311-alpine                  python    647af4e21bcb   6 weeks ago         58.6MB

docker run python-311-alpine:python
Python 3.11.13

--
--
PYTHON 3.12 DIRECTLY
docker build -f python-3.12-Dockerfile . -t python312:python -D

docker images | grep -E 'TAG|python312' 
REPOSITORY                         TAG       IMAGE ID       CREATED             SIZE
python312                          python    085050585116   6 weeks ago         1.02GB

docker run python312:python
Python 3.12.11

--
PYTHON 3.12 SLIM
docker build -f python-3.12-slim-Dockerfile . -t python-312-slim:python -D

docker images | grep -E 'TAG|python-312-slim'
REPOSITORY                         TAG       IMAGE ID       CREATED             SIZE
python-312-slim                    python    8318e8e7726a   6 weeks ago         150MB                                   

docker run python-312-slim:python
Python 3.12.11

--
PYTHON 3.12 ALPINE
docker build -f python-3.12-alpine-Dockerfile . -t python-312-alpine:python -D

docker images | grep -E 'TAG|python-312-alpine' 
REPOSITORY                         TAG       IMAGE ID       CREATED             SIZE
python-312-alpine                  python    12249791d37d   6 weeks ago         52.9MB                                      

docker run python-312-alpine:python
Python 3.12.11


--
--
Simple Web server in Python
docker build -f python-3_12-webserver-Dockerfile -t python-312-webserver:python --no-cache --progress=plain .


docker images | grep -E 'TAG|python-312-webserver' 
REPOSITORY                         TAG       IMAGE ID       CREATED          SIZE
python-312-webserver               python    f08afbf0476b   19 seconds ago   52.9MB

docker run -p 8383:8383 python-312-webserver:python
Server running at http://127.0.0.1:8383/
. and running curl -v localhost:8383 from another terminal:
curl -v 127.0.0.1:8383
*   Trying 127.0.0.1:8383...
* Connected to 127.0.0.1 (127.0.0.1) port 8383
> GET / HTTP/1.1
> Host: 127.0.0.1:8383
> User-Agent: curl/8.7.1
> Accept: */*
> 
* Request completely sent off
* HTTP 1.0, assume close after body
< HTTP/1.0 200 OK
< Server: BaseHTTP/0.6 Python/3.12.11
< Date: Sun, 20 Jul 2025 22:57:35 GMT
< Content-type: text/html
< 
<!DOCTYPE html>
<html>
<head>
    <title> Web Server</title>
</head>
<body>
    <h1>Welcome to a Simple Web Server</h1>
</body>
* Closing connection
</html>%   


. Test detached docker container using curl
docker run -d -p 8383:8383 python-312-webserver:python && sleep 3 && curl -v 127.0.0.1:8383
fac2b147e6e422def87af2c6ce35a24d4e3b9e30698a46edb5a85372402e7232
*   Trying 127.0.0.1:8383...
* Connected to 127.0.0.1 (127.0.0.1) port 8383
> GET / HTTP/1.1
> Host: 127.0.0.1:8383
> User-Agent: curl/8.7.1
> Accept: */*
> 
* Request completely sent off
* HTTP 1.0, assume close after body
< HTTP/1.0 200 OK
< Server: BaseHTTP/0.6 Python/3.12.11
< Date: Sun, 20 Jul 2025 22:58:18 GMT
< Content-type: text/html
< 
<!DOCTYPE html>
<html>
<head>
    <title> Web Server</title>
</head>
<body>
    <h1>Welcome to a Simple Web Server</h1>
</body>
* Closing connection
</html>%


. Remove detached container:
docker kill fac2b147e6e4

. Check Python version 
docker run -it -p 8383:8383 python-312-webserver:python /bin/bash -c 'python3 --version'
docker: Error response from daemon: failed to create task for container: failed to create shim task: OCI runtime create failed: runc create failed: unable to start container process: error during container init: exec: "/bin/bash": stat /bin/bash: no such file or directory: unknown

Run 'docker run --help' for more information
---> This may be failing because the base image may not have bash SHELL

docker run -it -p 8383:8383 python-312-webserver:python sh -c 'python3 --version'
Python 3.12.11


--
--
Simple Web server in Python using Ubuntu base image
docker build -f python-3-ubuntu-webserver-Dockerfile -t python-312-ubuntu-webserver:python --no-cache --progress=plain .


docker images | grep -E 'TAG|python-3-ubuntu-webserver' 
REPOSITORY                         TAG       IMAGE ID       CREATED          SIZE
python-3-ubuntu-webserver          python    7f565fba2fc3   13 seconds ago   195MB


.Run Docker container in detached mode (web server in port 8484)
docker run -p 8484:8484 python-3-ubuntu-webserver:python
Server running at http://127.0.0.1:8484/
. and running curl -v localhost:8484 from another terminal:
*   Trying 127.0.0.1:8484...
* Connected to 127.0.0.1 (127.0.0.1) port 8484
> GET / HTTP/1.1
> Host: 127.0.0.1:8484
> User-Agent: curl/8.7.1
> Accept: */*
> 
* Request completely sent off
* HTTP 1.0, assume close after body
< HTTP/1.0 200 OK
< Server: BaseHTTP/0.6 Python/3.12.3
< Date: Sun, 20 Jul 2025 22:46:26 GMT
< Content-type: text/html
< 
<!DOCTYPE html>
<html>
<head>
    <title> Web Server</title>
</head>
<body>
    <h1>Welcome to a Simple Web Server</h1>
</body>
* Closing connection
</html>%  


. Test detached docker container using curl
docker run -d -p 8484:8484 python-3-ubuntu-webserver:python && sleep 3 && curl -v 127.0.0.1:8484
a2cb023e2edec96b51119903545c7213482f177e65d5381b8e8dc15d9ac1f9ba
*   Trying 127.0.0.1:8484...
* Connected to 127.0.0.1 (127.0.0.1) port 8484
> GET / HTTP/1.1
> Host: 127.0.0.1:8484
> User-Agent: curl/8.7.1
> Accept: */*
> 
* Request completely sent off
* HTTP 1.0, assume close after body
< HTTP/1.0 200 OK
< Server: BaseHTTP/0.6 Python/3.12.3
< Date: Sun, 20 Jul 2025 22:46:56 GMT
< Content-type: text/html
< 
<!DOCTYPE html>
<html>
<head>
    <title> Web Server</title>
</head>
<body>
    <h1>Welcome to a Simple Web Server</h1>
</body>
* Closing connection
</html>%   

. Remove detached container:
docker kill a2cb023e2ede

. Check Python version 
docker run -it -p 8484:8484 python-3-ubuntu-webserver:python /bin/bash -c 'python3 --version'
Python 3.12.3

docker run -it -p 8484:8484 python-3-ubuntu-webserver:python sh -c 'python3 --version'
Python 3.12.3

