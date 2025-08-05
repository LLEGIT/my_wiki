FROM postgres:17-alpine

# Set maintainer label
LABEL maintainer="my_wiki_project"
LABEL description="Custom PostgreSQL database for Wiki.js"

# Define build arguments that can be passed from docker-compose
ARG POSTGRES_DB=wiki
ARG POSTGRES_USER=wikijs
ARG POSTGRES_PASSWORD=changeme

# Set environment variables from build args
ENV POSTGRES_DB=${POSTGRES_DB}
ENV POSTGRES_USER=${POSTGRES_USER}
ENV POSTGRES_PASSWORD=${POSTGRES_PASSWORD}

# Install additional tools if needed
RUN apk add --no-cache \
    postgresql-contrib

# Create custom initialization scripts directory
COPY ./init/ /docker-entrypoint-initdb.d/

# Expose PostgreSQL port
EXPOSE 5432

# Use the default postgres entrypoint
# No need to override CMD as the base image handles it well
