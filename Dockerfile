FROM cloud9/workspace
## FROM    ubuntu:14.04
MAINTAINER Jason Zucchetto

RUN echo "Version 1.0"

# Install MongoDB
# https://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/
RUN \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \
    echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.0.list && \
    apt-get update
RUN MONGODB_VERSION=3.0.4 sh -c 'apt-get install -y \
    mongodb-org=$MONGODB_VERSION \
    mongodb-org-server=$MONGODB_VERSION \
    mongodb-org-shell=$MONGODB_VERSION \
    mongodb-org-mongos=$MONGODB_VERSION \
    mongodb-org-tools=$MONGODB_VERSION'

# Set up the home directory
RUN rm -rf /home/ubuntu/workspace
ADD ./files /home/ubuntu
RUN chown -R ubuntu:ubuntu /home/ubuntu && \
    chown -R ubuntu:ubuntu /home/ubuntu

EXPOSE 8080
EXPOSE 8081
EXPOSE 8082

