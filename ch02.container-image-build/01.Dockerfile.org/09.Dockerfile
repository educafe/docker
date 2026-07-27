FROM ubuntu:24.04
ARG APP_ENV=production
RUN echo "Building the application in ${APP_ENV} mode"
ARG INSTALL_TOOL=false
RUN if [ "$INSTALL_TOOL" = "true" ]; then \
       apt-get update && apt-get install -y curl; \
    fi
CMD ["echo", "Build complete"]

