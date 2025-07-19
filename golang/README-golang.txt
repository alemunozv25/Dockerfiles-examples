--
COMPARISON OF GOLANG IMAGES (Direct vs via Ubuntu)
docker images | grep -E 'TAG|go-' 
REPOSITORY                                               TAG                    IMAGE ID       CREATED          SIZE
go-default-ubuntu-web-hello-world                        go                     0a82eb3f2d40   3 minutes ago    700MB
go-1.24-web-hello-world                                  go                     a5bf1a8aba22   7 minutes ago    952MB
go-1.24-ubuntu-web-hello-world                           go                     a4dc01fc9f53   22 minutes ago   580MB

--
GOLANG 1.24 DIRECTLY
.Use 1.24 directory
.Before Dockerfile (to enable module dependencies tracking):
go mod init webserver-hello-world

.Dockerfile:
docker build -f golang-1.24-Dockerfile -t go-1.24-web-hello-world:go --no-cache --progress=plain .
docker images | grep -E 'TAG|go-1.24-web' 
REPOSITORY                         TAG       IMAGE ID       CREATED         SIZE
go-1.24-web-hello-world            go        71e35d30c726   2 minutes ago   952MB

docker run -p 8888:8888 go-1.24-web-hello-world:go 
. and running curl -v localhost:8888 from another terminal:
curl -v 127.0.0.1:8888
*   Trying 127.0.0.1:8888...
* Connected to 127.0.0.1 (127.0.0.1) port 8888
> GET / HTTP/1.1
> Host: 127.0.0.1:8888
> User-Agent: curl/8.7.1
> Accept: */*
> 
* Request completely sent off
< HTTP/1.1 200 OK
< Date: Sat, 19 Jul 2025 14:47:00 GMT
< Content-Length: 14
< Content-Type: text/plain; charset=utf-8
< 
Hello, World!
* Connection #0 to host 127.0.0.1 left intact


.Run Docker container in detached mode (web server in port 8888)
docker run -d -p 8888:8888 go-1.24-web-hello-world:go


. Test detached docker container using curl
docker run -d -p 8888:8888 go-1.24-web-hello-world:go && sleep 1 && curl -v 127.0.0.1:8888
3f91b4fb025e68e459f8e454cbbe2404afb3c54aaf18e09621fd9ddbc6830252
*   Trying 127.0.0.1:8888...
* Connected to 127.0.0.1 (127.0.0.1) port 8888
> GET / HTTP/1.1
> Host: 127.0.0.1:8888
> User-Agent: curl/8.7.1
> Accept: */*
> 
* Request completely sent off
< HTTP/1.1 200 OK
< Date: Sat, 19 Jul 2025 17:52:33 GMT
< Content-Length: 14
< Content-Type: text/plain; charset=utf-8
< 
Hello, World!
* Connection #0 to host 127.0.0.1 left intact

. Remove detached container:
docker kill 3f91b4fb025e

docker run -it -p 8888:8888 go-1.24-web-hello-world:go /bin/bash -c 'go version'
go version go1.24.5 linux/arm64


---
GOLANG DEFAULT IN UBUNTU 24.04
docker build -f golang-ubuntu-Dockerfile -t go-default-ubuntu-web-hello-world:go --no-cache --progress=plain .
docker images | grep -E 'TAG|go-default-ubuntu-web' 
REPOSITORY                                               TAG                    IMAGE ID       CREATED          SIZE
go-default-ubuntu-web-hello-world                        go                     0a82eb3f2d40   17 seconds ago   700MB

docker run -p 8888:8888 go-default-ubuntu-web-hello-world:go
. and running curl -v 127.0.0.1:8888 from another terminal:
curl -v 127.0.0.1:8888
*   Trying 127.0.0.1:8888...
* Connected to 127.0.0.1 (127.0.0.1) port 8888
> GET / HTTP/1.1
> Host: 127.0.0.1:8888
> User-Agent: curl/8.7.1
> Accept: */*
> 
* Request completely sent off
< HTTP/1.1 200 OK
< Date: Sat, 19 Jul 2025 17:56:12 GMT
< Content-Length: 14
< Content-Type: text/plain; charset=utf-8
< 
Hello, World!
* Connection #0 to host 127.0.0.1 left intact

. Test detached docker container using curl
docker run -d -p 8888:8888 go-default-ubuntu-web-hello-world:go && sleep 1 && curl -v 127.0.0.1:8888
85743d760de51f55f446f61544df105e4c4d8cb3aef7712f6d4353f30777cbaf
*   Trying 127.0.0.1:8888...
* Connected to 127.0.0.1 (127.0.0.1) port 8888
> GET / HTTP/1.1
> Host: 127.0.0.1:8888
> User-Agent: curl/8.7.1
> Accept: */*
> 
* Request completely sent off
< HTTP/1.1 200 OK
< Date: Sat, 19 Jul 2025 17:57:08 GMT
< Content-Length: 14
< Content-Type: text/plain; charset=utf-8
< 
Hello, World!
* Connection #0 to host 127.0.0.1 left intact

. Remove detached container:
docker kill 85743d760de5

. Checking GOLANG version
docker run -it -p 8888:8888 go-default-ubuntu-web-hello-world:go /bin/bash -c 'go version'
go version go1.22.2 linux/arm64



---
GOLANG 1.24 IN UBUNTU 24.04
docker build -f golang-1.24-ubuntu-Dockerfile -t go-1.24-ubuntu-web-hello-world:go --no-cache --progress=plain .
docker images | grep -E 'TAG|go-1.24-ubuntu-web' 
REPOSITORY                                               TAG                    IMAGE ID       CREATED          SIZE
go-1.24-ubuntu-web-hello-world                           go                     a4dc01fc9f53   34 seconds ago   580MB

docker run -p 8888:8888 go-1.24-ubuntu-web-hello-world:go
. and running curl -v 127.0.0.1:8888 from another terminal:
curl -v 127.0.0.1:8888
*   Trying 127.0.0.1:8888...
* Connected to 127.0.0.1 (127.0.0.1) port 8888
> GET / HTTP/1.1
> Host: 127.0.0.1:8888
> User-Agent: curl/8.7.1
> Accept: */*
> 
* Request completely sent off
< HTTP/1.1 200 OK
< Date: Sat, 19 Jul 2025 17:37:46 GMT
< Content-Length: 14
< Content-Type: text/plain; charset=utf-8
< 
Hello, World!
* Connection #0 to host 127.0.0.1 left intact

. Test detached docker container using curl. In QEMU sleep=1 was sufficient, but in VZ sleep=2 is required
#docker run -d -p 8888:8888 go-1.24-ubuntu-web-hello-world:go && sleep 1 && curl -v 127.0.0.1:8888
docker run -d -p 8888:8888 go-1.24-ubuntu-web-hello-world:go && sleep 2 && curl -v 127.0.0.1:8888
270a1f7ba049dfa6f51c88a59595381aa8a98b7b338cb4fe74a1600aace0c9cd
*   Trying 127.0.0.1:8888...
* Connected to 127.0.0.1 (127.0.0.1) port 8888
> GET / HTTP/1.1
> Host: 127.0.0.1:8888
> User-Agent: curl/8.7.1
> Accept: */*
> 
* Request completely sent off
< HTTP/1.1 200 OK
< Date: Sat, 19 Jul 2025 17:44:14 GMT
< Content-Length: 14
< Content-Type: text/plain; charset=utf-8
< 
Hello, World!
* Connection #0 to host 127.0.0.1 left intact

. Remove detached container:
docker kill 270a1f7ba049

. Checking GOLANG version
docker run -it -p 8888:8888 go-1.24-ubuntu-web-hello-world:go /bin/bash -c 'go version'
go version go1.24.5 linux/amd64


---

