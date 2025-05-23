#!/bin/sh
CURL=`which curl`

FEATURE="$1"
ADDED="$2"
DELETED="$3"
TOTAL="$4"

# Load environment variables from .env file
if [ -f .env ]; then
  source .env
fi

if [ -z "$REDCAP_API_TOKEN" ]; then
  echo "Environment variable REDCAP_API_TOKEN is not set. Exiting."
  exit 1
fi

#Upload the Video file to the REDCap project
$CURL -X POST "$REDCAP_API_URL" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "token=$REDCAP_API_TOKEN" \
  -d "content=record" \
  -d "format=json" \
  -d "type=flat" \
  -d "data=[{\"record_id\":\"$FEATURE\",\"lines_added\":\"$ADDED\",\"lines_removed\":\"$DELETED\",\"total_lines_changed\":\"$TOTAL\",\"feature_changes_complete\":\"2\"}]" \
  -d "returnContent=ids" \
  -d "returnFormat=json"