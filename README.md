# iDRAC6 Tools

This an image for supporting the old command-line interface for iDRAC6 and also to run a Virtual Console via VNC. 

## Pulling the Container Image from DockerHub

This image is available on DockerHub, so you can pull it and use the instructions there if you would prefer:

[https://hub.docker.com/r/jlphillips/idrac6-tools](https://hub.docker.com/r/jlphillips/idrac6-tools)

## Building the Container Image

If you would prefer building your own image, then clone the repo and build as follows:

```
git clone https://github.com/jlphillipsphd/idrac6-tools.git
cd idrac6-tools
docker build -t idrac6-tools:trusty -f Dockerfile .
```

## Running the Container
Note that the current working directory will be mounted at /mnt inside of the container so that you can access your private key and public cert, or any relevant installation media images should be in the current directory for mounting on /mnt (or pick something other than ${PWD}). Use a VNC viewer to connect to port 5900 once the container is running - the console script should autostart in the openbox session, but you can right-click and start a new terminal and then run `start-virtual-console.sh` as well.
```
docker run -it --rm -v ${PWD}:/mnt -p 5900:5900 idrac6-tools:trusty
```
If want to use the command-line tools only, then it may be more convenient to just start a shell inside of the container instead:
```
docker run -it --rm -v ${PWD}:/mnt idrac6-tools:trusty /bin/bash
```

## Administrative How-Tos

###  Upload new private key
```
idracadm -r my.server.org -i sslkeyupload -t 1 -f /mnt/myidrac.key
```

### Upload new certificate: use cert (w/ issuer) version of the cert...
```
idracadm -r my.server.org -i sslcertupload -t 1 -f /mnt/myidrac.pem
```

