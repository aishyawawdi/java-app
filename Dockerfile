FROM alpine/git as clone
WORKDIR /myapp
RUN git clone https://github.com/spring-projects/spring-petclinic.git

FROM maven:3.5-jdk-8-alpine as bulid
WORKDIR /myapp
COPY --from=clone /myapp/spring-petclinic /myapp
RUN mvn install

FROM openjdk:8-jre-alpine
WORKDIR /myapp
COPY --from=bulid /myapp/target/spring-petclinic-2.4.0.BUILD-SNAPSHOT.jar /myapp
CMD ["java", "-jar","spring-petclinic-2.4.0.BUILD-SNAPSHOT.jar"]
