#Overview
This project is a simple Docker image that runs [JetBrains PyCharm IDE](http://www.jetbrains.com/).

#Prerequisites
* a working [Docker](http://docker.io) engine
   ```
   docker --version
   Docker version 1.12.1, build 23cf638
   ```
* a working [Docker Compose](http://docker.io) installation
   ``` 
   $ docker-compose --version
   docker-compose version 1.8.0, build f3628c7
   ```


#Building
Type `docker-compose build` to build the image.

#Installation
Docker will automatically install the newly built image into the cache.

#Tips and Tricks

##Launching The Image
In case if you want own customization, edit `.env` file or set f.e. `export HOME=/your/path/developer` before run running `docker-compose up`.

If you want to push final image to docker hub 
```
export DOCKER_HUB_USER="your_user/"
docker-compose build
docker push ${DOCKER_HUB_USER}pycharm-community:2016.2.3
```
You can use already an exisited builded image `adan/pycharm-community:2016.2.3`,
but for that you need to comment line `build: .` in `docker-compose.yml` before next command.
 
And finaly, `docker-compose up` will launch the image allowing you to begin working on projects.
The Docker Compose file is configured to mount your home directory into the container.  

#Troubleshooting

##User Account
The image assumes that the account running the continer will have a user and group id of 1000:1000.  This allows the container 
to save files in your home directory and keep the proper permissions.

##X-Windows
If the image complains that it cannot connect to your X server, simply run `xhost +` to allow the container to connect 
to your X server.

#License and Credits
This project is licensed under the [Apache License Version 2.0, January 2004](http://www.apache.org/licenses/).

#List of Changes

