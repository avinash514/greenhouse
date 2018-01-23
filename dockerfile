# Pull base image
From tomcat:8-jre8

# Maintainer
MAINTAINER "Avinash Dimmeta">

# Copy to images tomcat path
ADD ./target/app.war /usr/local/tomcat/webapps/
