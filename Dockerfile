FROM openjdk:11.0.11-jre
RUN apt update && \
    apt install -y maven docker.io git
COPY ./prod/Dockerfile /tmp