#
# BUILD
#
FROM gradle:7.2-jdk11 AS gradle_build
USER root
WORKDIR /hexagon

COPY src src
COPY build.gradle build.gradle
RUN gradle --quiet

#
# RUNTIME
#
FROM tomcat:10.0.14-jre17-temurin
ENV DBSTORE postgresql
ENV POSTGRESQL_DB_HOST tfb-database

COPY --from=gradle_build /hexagon/build/libs/ROOT.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
