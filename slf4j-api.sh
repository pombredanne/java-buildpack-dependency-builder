#!/usr/bin/env bash

set -e -o pipefail

source $(dirname "$0")/common.sh

download_uri() {
  if [[ -z "$DOWNLOAD_VERSION" ]]; then
    echo "DOWNLOAD_VERSION must be set" >&2
    exit 1
  fi

  echo $(maven_central_uri 'org.slf4j' 'slf4j-api' $DOWNLOAD_VERSION)
}

upload_path() {
  if [[ -z "$UPLOAD_VERSION" ]]; then
    echo "UPLOAD_VERSION must be set" >&2
    exit 1
  fi

  echo "/slf4j-api/slf4j-api-$UPLOAD_VERSION.jar"
}

DOWNLOAD_URI=$(download_uri)
UPLOAD_PATH=$(upload_path)
INDEX_PATH="/slf4j-api/index.yml"

transfer_direct $DOWNLOAD_URI $UPLOAD_PATH
update_index $INDEX_PATH $UPLOAD_VERSION $UPLOAD_PATH
invalidate_cache $INDEX_PATH $UPLOAD_PATH
