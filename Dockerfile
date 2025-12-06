# FROM openjdk:8-jre-alpine

# EXPOSE 8080

# RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# copy whatever jar is built
# COPY ./build/libs/*.jar /usr/app/app.jar
# WORKDIR /usr/app

# USER appuser

# HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
#   CMD wget --spider -q http://localhost:8080/health || exit 1

# ENTRYPOINT ["java", "-jar", "app.jar"]


## Testing new Dockerfile ##
FROM openjdk:8-jre-alpine

# Expose application port
EXPOSE 8080

# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup \
    && apk add --no-cache curl  # install curl for healthcheck

# Copy built JAR into container
COPY ./build/libs/*.jar /usr/app/app.jar
WORKDIR /usr/app

# Run as non-root user
USER appuser

# Healthcheck using Spring Boot Actuator endpoint
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD curl --fail http://localhost:8080/actuator/health || exit 1

# Start the app
ENTRYPOINT ["java", "-jar", "app.jar"]
