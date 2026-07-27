ARG VERSION=24.04
FROM ubuntu:$VERSION
ARG ENVIRONMENT=prod
RUN if [ "$ENVIRONMENT" = "test" ]; then \
			apt-get update && apt-get install -y curl; \
		else \
			apt-get update && apt-get install -y net-tools; \
		fi

	




