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
