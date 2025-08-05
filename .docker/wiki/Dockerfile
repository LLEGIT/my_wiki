FROM ghcr.io/requarks/wiki:2

# Set maintainer label
LABEL maintainer="my_wiki_project"
LABEL description="Custom Wiki.js instance"

# Define build arguments that can be passed from docker-compose
ARG DB_TYPE=postgres
ARG DB_HOST=db
ARG DB_PORT=5432
ARG DB_USER=wikijs
ARG DB_PASS=changeme
ARG DB_NAME=wiki

# Switch to root to install packages
USER root

# Install additional tools if needed
RUN apk add --no-cache \
    curl \
    git \
    openssh-client

# Create a custom config directory
RUN mkdir -p /wiki/custom

# Copy custom configuration files if any
COPY ./config/ /wiki/custom/

# Create a healthcheck script
COPY ./scripts/healthcheck.sh /usr/local/bin/healthcheck.sh
RUN chmod +x /usr/local/bin/healthcheck.sh

# Set environment variables from build args
ENV DB_TYPE=${DB_TYPE}
ENV DB_HOST=${DB_HOST}
ENV DB_PORT=${DB_PORT}
ENV DB_USER=${DB_USER}
ENV DB_PASS=${DB_PASS}
ENV DB_NAME=${DB_NAME}

# Switch back to the default user (the base image uses node user)
USER node

# Expose Wiki.js port
EXPOSE 3000

# Add healthcheck
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD /usr/local/bin/healthcheck.sh

# Use the default wiki entrypoint
# The base image already sets up the proper CMD and user
