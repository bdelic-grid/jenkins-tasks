FROM maven:3.9.9-eclipse-temurin-17 AS build

COPY ./spring-petclinic /app/spring-petclinic

WORKDIR /app/spring-petclinic

RUN mvn package -DskipTests



FROM alpine:3.21

WORKDIR /app

RUN apk add openjdk17

COPY --from=build /app/spring-petclinic/target/spring-petclinic*.jar /app/petclinic.jar

EXPOSE 8080

ENTRYPOINT ["java"]
CMD ["-jar", "petclinic.jar"]

