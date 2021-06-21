FROM alpine:3.10
RUN apk add openjdk8-jre-base && \
    java -version
RUN mkdir /opt/tomcat
WORKDIR /opt/tomcat
RUN wget -nv https://apache-mirror.rbc.ru/pub/apache/tomcat/tomcat-9/v9.0.46/bin/apache-tomcat-9.0.46.tar.gz && \
	tar xvzf apache-tomcat-9.0.46.tar.gz --strip-components 1 --directory . && \
	rm -rf apache-tomcat-9.0.46.tar.gz && \
	rm -rf /opt/tomcat/webapps/* 
CMD ["/opt/tomcat/bin/catalina.sh", "run"]