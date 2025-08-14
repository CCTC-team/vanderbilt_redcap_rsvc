#!/bin/sh

set -e

CURL=`which curl`

VIDEO_FILE=$1
FILENAME=$2
FOLDER_ID=$3

ID=`echo $VIDEO_FILE | rev | cut -d/ -f 1 | rev | cut -d' ' -f 1`
PASSING_DURATION=`grep "file=\"redcap_rsvc.*$ID" ../coverage/test-results  -r --before-context=1 | grep 'tests="1" failures="0"'| cut -d\" -f 4`

if [ -z "$PASSING_DURATION" ]; then
  echo The feature did not pass.  Skipping field updates.
  exit
fi

echo duration: $DURATION
exit


# Load environment variables from .env file
if [ -f .env ]; then
  source .env
fi

if [ -z "$REDCAP_API_TOKEN" ]; then
  echo "Environment variable REDCAP_API_TOKEN is not set. Exiting."
  exit 1
fi

#Upload the Video file to the REDCap project
$CURL -H "Accept: application/json" \
      -F "token=$REDCAP_API_TOKEN" \
      -F "content=fileRepository" \
      -F "action=import" \
      -F "folder_id=$FOLDER_ID" \
      -F "filename=$FILENAME" \
      -F "file=@\"$VIDEO_FILE\"" \
      $REDCAP_API_URL
