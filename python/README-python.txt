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


