#!/bin/bash

#Wait for elastichsearch to be available
echo "Waiting for ElasticSearch to be available..."
until curl -sS http://es:9200; do
    sleep 5
done
echo "ElasticSearch is available. Starting Flask app"
python flask-app/app.py