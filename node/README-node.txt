COMPARING NODE IMAGES SIZING
docker images | grep -E 'TAG|node'
REPOSITORY                         TAG       IMAGE ID       CREATED          SIZE
ubuntu-node22-nvm                  node      72226de35566   2 minutes ago    402MB
ubuntu-node22                      node      86c02627bf31   18 minutes ago   390MB
ubuntu-node18-nvm                  node      53b1af9a4dbf   27 minutes ago   361MB
ubuntu-node18                      node      fe88966dddf0   26 hours ago     368MB
node22-direct                      node      51d0faf5f48a   2 days ago       1.12GB
node18-direct                      node      4ebe5de733dc   3 months ago     1.09GB

--
VIEW DETAILED LOGS DURING BUILD
docker build -f ubuntulatest-node18-nvm-Dockerfile . -t ubuntu-node18-nvm:node --no-cache --progress=plain 2>&1 | tee build-ubuntu-node18-nvm.log
docker build -f ubuntulatest-node18-nvm-Dockerfile -t ubuntu-node18-nvm:node --no-cache --progress=plain .

--
NODE 18 (via Ubuntu and node18 specific package)
docker build -f ubuntulatest-node18-Dockerfile . -t ubuntu-node18:node -D
docker images | grep -E 'TAG|ubuntu-node18'                               
REPOSITORY                         TAG       IMAGE ID       CREATED          SIZE
ubuntu-node18                      node      fe88966dddf0   8 minutes ago    368MB

docker run ubuntu-node18:node
v18.20.8

--
NODE 18 (via Ubuntu and NVM)
docker build -f ubuntulatest-node18-nvm-Dockerfile -t ubuntu-node18-nvm:node --no-cache --progress=plain .
docker images | grep -E 'TAG|ubuntu-node18-nvm' 
REPOSITORY                         TAG       IMAGE ID       CREATED              SIZE
ubuntu-node18-nvm                  node      53b1af9a4dbf   About a minute ago   361MB

docker run ubuntu-node18-nvm:node
v18.20.8

--
NODE 18 (DIRECT)
docker build -f node18-Dockerfile . -t node18-direct:node -D
docker images | grep -E 'TAG|node18-direct'                 
REPOSITORY                         TAG       IMAGE ID       CREATED          SIZE
node18-direct                      node      4ebe5de733dc   3 months ago     1.09GB

docker run node18-direct:node
v18.20.8


--
NODE 22 (via Ubuntu and node18 specific package)
docker build -f ubuntulatest-node22-Dockerfile . -t ubuntu-node22:node  
docker images | grep -E 'TAG|ubuntu-node22'                              
REPOSITORY                         TAG       IMAGE ID       CREATED          SIZE
ubuntu-node22                      node      86c02627bf31   38 seconds ago   390MB

docker run ubuntu-node22:node                                            
v22.17.1


--
NODE 22 (via Ubuntu and NVM)
docker build -f ubuntulatest-node22-nvm-Dockerfile -t ubuntu-node22-nvm:node --no-cache --progress=plain .
docker images | grep -E 'TAG|ubuntu-node22-nvm' 
REPOSITORY                         TAG       IMAGE ID       CREATED          SIZE
ubuntu-node22-nvm                  node      72226de35566   31 seconds ago   402MB

docker run ubuntu-node22-nvm:node
v22.17.1

--
NODE 22 (DIRECT)
docker build -f node22-Dockerfile . -t node22-direct:node -D
docker images | grep -E 'TAG|node22-direct'
REPOSITORY                         TAG       IMAGE ID       CREATED          SIZE
node22-direct                      node      51d0faf5f48a   2 days ago       1.12GB

docker run node22-direct:node
v22.17.1

---
CHECK 
➜  node docker run -it ubuntu-node18:node /bin/bash -c 'node --version' 
v18.20.6
➜  node docker run -it node18-direct:node /bin/bash -c 'node --version'
v18.20.8
➜  node docker run -it ubuntu-node18-nvm:node /bin/bash -c 'node --version'  
v18.20.8


---
---
SIMPLE SERVER USING NODE 22

docker build -f node22-webserver-Dockerfile -t node22-webserver:node --no-cache --progress=plain .

docker images | grep -E 'TAG|node22-webserver' 
REPOSITORY                         TAG       IMAGE ID       CREATED              SIZE
node22-webserver                   node      bac3d65a5ae8   About a minute ago   159MB

docker run -p 8181:8181 node22-webserver:node
Server running at http://127.0.0.1:8181/
. and running curl -v localhost:8181 from another terminal:
curl -v 127.0.0.1:8181
*   Trying 127.0.0.1:8181...
* Connected to 127.0.0.1 (127.0.0.1) port 8181
> GET / HTTP/1.1
> Host: 127.0.0.1:8181
> User-Agent: curl/8.7.1
> Accept: */*
> 
* Request completely sent off
< HTTP/1.1 200 OK
< Content-Type: text/plain
< Date: Tue, 22 Jul 2025 15:13:18 GMT
< Connection: keep-alive
< Keep-Alive: timeout=5
< Content-Length: 27
< 
Hello, Node.js Web Server!
* Connection #0 to host 127.0.0.1 left intact


. Test detached docker container using curl
docker run -d -p 8181:8181 node22-webserver:node && sleep 3 && curl -v 127.0.0.1:8181
c07673f097bac4f54f5018919c07adfa4018d9d78bb1f8abfa4d37d3e0614451
*   Trying 127.0.0.1:8181...
* Connected to 127.0.0.1 (127.0.0.1) port 8181
> GET / HTTP/1.1
> Host: 127.0.0.1:8181
> User-Agent: curl/8.7.1
> Accept: */*
> 
* Request completely sent off
< HTTP/1.1 200 OK
< Content-Type: text/plain
< Date: Tue, 22 Jul 2025 14:27:31 GMT
< Connection: keep-alive
< Keep-Alive: timeout=5
< Content-Length: 27
< 
Hello, Node.js Web Server!
* Connection #0 to host 127.0.0.1 left intact

. Remove detached container:
docker kill c07673f097ba

. Check Node version 
docker run -it -p 8181:8181 node22-webserver:node /bin/bash -c 'node --version'
Server running at http://0.0.0.0:8181/
+ Cannot get out...had to use "docker kill ..." to end container. 
-> This happens because of the ENTRYPOINT command 

Trying with entrypoint replacement and bash shell
docker run --entrypoint bash node22-webserver:node -c 'node --version'

docker: Error response from daemon: failed to create task for container: failed to create shim task: OCI runtime create failed: runc create failed: unable to start container process: error during container init: exec: "bash": executable file not found in $PATH: unknown

Run 'docker run --help' for more information
-> This happens because bash shell may not exist in a node base image


Testing with sh:
docker run -it -p 8181:8181 node22-webserver:node sh -c 'node --version'
Server running at http://0.0.0.0:8181/
+ Cannot get out...had to use "docker kill ..." to end container.  This happens because of the ENTRYPOINT command

Trying with entrypoint replacement and sh shell
docker run --entrypoint sh node22-webserver:node -c 'node --version'
v22.17.1


---
---
SIMPLE SERVER USING NODE 22 via Ubuntu 24.04

docker build -f node22-ubuntu-webserver-Dockerfile -t node22-ubuntu-webserver:node --no-cache --progress=plain .

docker images | grep -E 'TAG|node22-ubuntu-webserver' 
REPOSITORY                         TAG       IMAGE ID       CREATED          SIZE
node22-ubuntu-webserver            node      6f450e97b62a   40 seconds ago   391MB

docker run -p 8282:8282 node22-ubuntu-webserver:node
Server running at http://127.0.0.1:8282/
. and running curl -v localhost:8282 from another terminal:
curl -v 127.0.0.1:8282
*   Trying 127.0.0.1:8282...
* Connected to 127.0.0.1 (127.0.0.1) port 8282
> GET / HTTP/1.1
> Host: 127.0.0.1:8282
> User-Agent: curl/8.7.1
> Accept: */*
> 
* Request completely sent off
< HTTP/1.1 200 OK
< Content-Type: text/plain
< Date: Tue, 22 Jul 2025 15:40:16 GMT
< Connection: keep-alive
< Keep-Alive: timeout=5
< Content-Length: 27
< 
Hello, Node.js Web Server!
* Connection #0 to host 127.0.0.1 left intact


. Test detached docker container using curl
docker run -d -p 8282:8282 node22-ubuntu-webserver:node && sleep 3 && curl -v 127.0.0.1:8282
367b44418587f96c5f31c96d312082b2f746a1a3d1c7ee17ff38868848706cc8
*   Trying 127.0.0.1:8282...
* Connected to 127.0.0.1 (127.0.0.1) port 8282
> GET / HTTP/1.1
> Host: 127.0.0.1:8282
> User-Agent: curl/8.7.1
> Accept: */*
> 
* Request completely sent off
< HTTP/1.1 200 OK
< Content-Type: text/plain
< Date: Tue, 22 Jul 2025 15:42:56 GMT
< Connection: keep-alive
< Keep-Alive: timeout=5
< Content-Length: 27
< 
Hello, Node.js Web Server!
* Connection #0 to host 127.0.0.1 left intact

. Remove detached container:
docker kill 367b44418587

. Check Node version 
docker run -it -p 8282:8282 node22-ubuntu-webserver:node /bin/bash -c 'node --version'
Server running at http://0.0.0.0:8282/
+ Cannot get out...had to use "docker kill ..." to end container
-> This happens because of the ENTRYPOINT command 

Trying with entrypoint replacement and bash shell
docker run --entrypoint bash node22-ubuntu-webserver:node -c 'node --version'
v22.17.1


.Testing with sh:
docker run -it -p 8282:8282 node22-ubuntu-webserver:node sh -c 'node --version'
Server running at http://0.0.0.0:8282/
+ Cannot get out...had to use "docker kill ..." to end container
-> This happens because of the ENTRYPOINT command

Trying with entrypoint replacement and sh shell
docker run --entrypoint sh node22-ubuntu-webserver:node -c 'node --version'
v22.17.1
