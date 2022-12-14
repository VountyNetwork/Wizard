FROM gradle:7.6-alpine AS build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build

FROM openjdk:16-slim

EXPOSE 4677

RUN mkdir /app

WORKDIR /app

COPY --from=build /home/gradle/src/build/libs/*.jar /app/Wizard.jar

ENTRYPOINT ["java", "-jar", "/app/Wizard.jar", "ignoreRoot=true"]
