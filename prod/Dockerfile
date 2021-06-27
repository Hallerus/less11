FROM alpine:3.10
RUN apk add openjdk8-jre-base
RUN mkdir /opt/tomcat
WORKDIR /opt/tomcat
RUN wget -nv https://mirror.linux-ia64.org/apache/tomcat/tomcat-9/v9.0.48/bin/apache-tomcat-9.0.48.tar.gz && \
        tar xvzf apache-tomcat-9.0.48.tar.gz --strip-components 1 --directory . && \
        rm -rf apache-tomcat-9.0.48.tar.gz && \
        rm -rf /opt/tomcat/webapps/*
COPY /tmp/boxfuse/target/hello-1.0.war /opt/tomcat/webapps/
CMD ["/opt/tomcat/bin/catalina.sh", "run"]