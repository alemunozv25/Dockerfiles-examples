
docker build -f scratch-Dockerfile . -t scratch:alex
docker run scratch:alex

--
docker build -f busybox-Dockerfile . -t busybox:alex
docker images | grep -E 'TAG|busybox'
REPOSITORY                                               TAG                    IMAGE ID       CREATED             SIZE
busybox                                                  alex                   be8e921d72bd   39 seconds ago      4.04MB
rancher/mirrored-library-busybox                         1.36.1                 e99306e01437   2 years ago         4.04MB

docker run busybox:alex
Today is a good day

--
docker build -f alpine-Dockerfile . -t alpine:alex
docker images | grep -E 'TAG|alpine'   
REPOSITORY                                               TAG                    IMAGE ID       CREATED          SIZE
alpine                                                   alex                   b43ae216a111   15 seconds ago   8.52MB
alpine                                                   latest                 2abc5e834071   6 weeks ago      8.52MB

docker run alpine:alex
Today is a good day

--
docker build -f ubuntu24-Dockerfile . -t ubuntu24:alex
docker images | grep -E 'TAG|ubuntu24'                   
REPOSITORY                                               TAG                    IMAGE ID       CREATED          SIZE
ubuntu24                                                 alex                   96e6289dc244   25 seconds ago   101MB

docker run ubuntu24:alex
Today is a good day

--
docker build -f debianlatest-Dockerfile . -t debian-latest:alex
docker images | grep -E 'TAG|debian'                              
REPOSITORY                                               TAG                    IMAGE ID       CREATED          SIZE
debian-latest                                            alex                   78adc728a57b   22 seconds ago   139MB

docker run debian-latest:alex
Today is a good day

--
SUSE LTSS
docker build -f suse12-LTSS-Dockerfile . -t suse12-ltss:alex -D
FAILS...requires authorization
ERROR: failed to build: failed to solve: registry.suse.com/suse/ltss/sle12.5/sles12sp5:latest: pull access denied, repository does not exist or may require authorization: server message: insufficient_scope: authorization failed

docker build -f suse15-LTSS-Dockerfile . -t suse15-ltss:alex -D
FAILS...requires authorization
ERROR: failed to build: failed to solve: registry.suse.com/suse/ltss/sle15.5/sle15:15.5: pull access denied, repository does not exist or may require authorization: server message: insufficient_scope: authorization failed

--
SUSE BCI
docker build -f suse15-bci-Dockerfile . -t suse15-bci:alex -D
docker images | grep -E 'TAG|suse'                                
REPOSITORY                                               TAG                    IMAGE ID       CREATED             SIZE
suse15-bci                                               alex                   4e9f6286d8c7   5 minutes ago       135MB

docker run suse15-bci:alex
Today is a good day

--
Rocky Linux
docker build -f rocky9-Dockerfile . -t rocky9:alex 
docker images | grep -E 'TAG|rocky'                            
REPOSITORY                                               TAG                    IMAGE ID       CREATED             SIZE
rocky9                                                   alex                   0b80780e985c   13 seconds ago      249MB

docker run rocky9:alex
Today is a good day

--
COMPARISON OF IMAGES SIZES for simple script in Docker container
docker images | grep -E 'TAG|alex' 
REPOSITORY                                               TAG                    IMAGE ID       CREATED             SIZE
rocky9                                                   alex                   0b80780e985c   6 minutes ago       249MB
suse15-bci                                               alex                   4e9f6286d8c7   22 minutes ago      135MB
debian-latest                                            alex                   78adc728a57b   59 minutes ago      139MB
ubuntu24                                                 alex                   96e6289dc244   About an hour ago   101MB
alpine                                                   alex                   b43ae216a111   About an hour ago   8.52MB
busybox                                                  alex                   be8e921d72bd   About an hour ago   4.04MB
scratch                                                  alex                   ba6652b75229   3 hours ago         37B

