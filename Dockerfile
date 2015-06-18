FROM    ubuntu:14.04
MAINTAINER Jason Zucchetto

RUN echo "Version 1.0"

# Cloud 9 workspace commands
RUN rm -rf /home/ubuntu/workspace
ADD ./files /home/ubuntu

RUN chown -R ubuntu:ubuntu /home/ubuntu && \
    chown -R ubuntu:ubuntu /home/ubuntu
    
RUN sudo -u ubuntu -i bash -l -c "rails new /home/ubuntu/workspace"

# Set up exercise
COPY 	./assets /assets
RUN		mkdir /mongodb-3.0.4
RUN		tar -xvf /assets/mongodb-linux-x86_64-ubuntu1404-3.0.4.tgz -C /mongodb-3.0.4

EXPOSE  27017
EXPOSE  27018
EXPOSE  27019

# Run the mongo client, this is required to keep the container running
CMD ["sh", "/assets/replica_set.sh"]




