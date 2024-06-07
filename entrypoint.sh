#!/bin/bash

# Fetch and process data to generate report
# Add your existing data fetching and processing logic here

# Generate report
curl -s "https://huggingface.co/api/models?sort=downloads" | jq -r '.[] | [.modelId, .downloads] | @csv' > /usr/src/app/top_models_report_$(date +'%Y%m%d_%H%M%S').csv

# Start HTTP server to serve the files
cd /usr/src/app
python3 -m http.server 8080

