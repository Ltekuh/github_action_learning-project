FROM openjdk:8-jre-alpine

EXPOSE 8080

# Create a non-root user and group
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

COPY ./build/libs/my-app-1.0-SNAPSHOT.jar /usr/app/
WORKDIR /usr/app

# Use the non-root user
USER appuser

# Add a healthcheck to ensure the app is running
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD wget --spider -q http://localhost:8080/health || exit 1

ENTRYPOINT ["java", "-jar", "my-app-1.0-SNAPSHOT.jar"]
