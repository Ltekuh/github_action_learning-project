FROM openjdk:8-jre-alpine

EXPOSE 8080

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# copy whatever jar is built
COPY ./build/libs/*.jar /usr/app/app.jar
WORKDIR /usr/app

USER appuser

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD wget --spider -q http://localhost:8080/health || exit 1

ENTRYPOINT ["java", "-jar", "app.jar"]
