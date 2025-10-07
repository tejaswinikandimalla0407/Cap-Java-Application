# Stage 1: Build the application
FROM maven:latest AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests
 
# Stage 2: Run the application
FROM openjdk:latest
 
WORKDIR /app
 
# Copy the packaged JAR file from the build stage
COPY --from=build /app/target/maven-web-application.war ./myapp.war
 
EXPOSE 8092
 
CMD ["java", "-jar", "myapp.war"]