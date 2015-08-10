FROM    ubuntu:14.04
MAINTAINER Jason Zucchetto

RUN echo "Version 1.0"

# Set up exercise
COPY 	./assets /assets
RUN		mkdir /mongodb-3.0.4
RUN		tar -xvf /assets/mongodb-linux-x86_64-ubuntu1404-3.0.4.tgz -C /mongodb-3.0.4

EXPOSE  8080
EXPOSE  8081
EXPOSE  8082

# Run the mongo client, this is required to keep the container running
CMD ["sh", "/assets/replica_set.sh"]




