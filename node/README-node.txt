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
v18.20.6

--
NODE 18 (via Ubuntu and NVM)
docker docker build -f ubuntulatest-node18-nvm-Dockerfile -t ubuntu-node18-nvm:node --no-cache --progress=plain .
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
* Empty reply from server
* Closing connection
curl: (52) Empty reply from server

.Run Docker container in detached mode (web server in port 8181)
docker run -d -p 8181:8181 node22-webserver:node


. Test detached docker container using curl
docker run -d -p 8181:8181 node22-webserver:node && sleep 3 && curl -v 127.0.0.1:8181
e1b681e83466523ab68a73b2483f5fb7f7c28b284af8db2a398d3e74044bf5d6
*   Trying 127.0.0.1:8181...
* Connected to 127.0.0.1 (127.0.0.1) port 8181
> GET / HTTP/1.1
> Host: 127.0.0.1:8181
> User-Agent: curl/8.7.1
> Accept: */*
> 
* Request completely sent off
* Empty reply from server
* Closing connection
curl: (52) Empty reply from server


. Remove detached container:
docker kill 3f91b4fb025e

. Check Node version 
docker run -it -p 8181:8181 node22-webserver:node /bin/bash -c 'node version'
node:internal/modules/cjs/loader:1404
  throw err;
  ^

Error: Cannot find module '/bin/bash'
    at Function._resolveFilename (node:internal/modules/cjs/loader:1401:15)
    at defaultResolveImpl (node:internal/modules/cjs/loader:1057:19)
    at resolveForCJSWithHooks (node:internal/modules/cjs/loader:1062:22)
    at Function._load (node:internal/modules/cjs/loader:1211:37)
    at TracingChannel.traceSync (node:diagnostics_channel:322:14)
    at wrapModuleLoad (node:internal/modules/cjs/loader:235:24)
    at Function.executeUserEntryPoint [as runMain] (node:internal/modules/run_main:171:5)
    at node:internal/main/run_main_module:36:49 {
  code: 'MODULE_NOT_FOUND',
  requireStack: []
}

Node.js v22.17.1

=> This is somehow expected since the base of Dockerfile is node:22-alpine and not an OS