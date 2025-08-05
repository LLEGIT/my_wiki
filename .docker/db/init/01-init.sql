#!/bin/bash
set -e

# This script runs when the database is first created
# You can add custom database setup here

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    -- Create any additional extensions if needed
    -- CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
    
    -- Set up any initial database configuration
    ALTER DATABASE $POSTGRES_DB SET timezone TO 'UTC';
    
    -- Log successful initialization
    SELECT 'Database initialized successfully for Wiki.js' as status;
EOSQL
