# Stage 1: Build the application
FROM maven:latest AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests
 
# Stage 2: Deploy to Tomcat
FROM tomcat:9.0
COPY --from=build /app/target/maven-web-application.war /usr/local/tomcat/webapps/ROOT.war
 
EXPOSE 8080
 
CMD ["catalina.sh", "run"]