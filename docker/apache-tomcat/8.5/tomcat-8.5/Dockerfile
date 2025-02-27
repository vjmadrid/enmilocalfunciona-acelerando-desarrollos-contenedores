FROM tomcat:8.5.47-jdk8-corretto

# Delete the webapps directory from the beginning
#RUN rm -rf /usr/local/tomcat/webapps/*

# Add a sample WAR file
#ADD sample.war /usr/local/tomcat/webapps/

# Add a new role and user structure
ADD tomcat-users.xml /usr/local/tomcat/conf/

# Activate the use of the web console (UI)
ADD context.xml /usr/local/tomcat/webapps/manager/META-INF/

EXPOSE 8080

CMD ["catalina.sh","run"]








