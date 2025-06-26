#!/bin/bash

# Usage: ./test_google_api_key_extended.sh <API_KEY>
#
# 2025.06.25 @nyxgeek -@trustedsec
#
# Made to test a Google API key for access to services. By default they are unrestricted.


API_KEY="$1"

if [ -z "$API_KEY" ]; then
  echo "Usage: $0 <API_KEY>"
  exit 1
fi

APIS=(
  # Geolocation API
  "https://www.googleapis.com/geolocation/v1/geolocate"

  # YouTube Data API
  "https://www.googleapis.com/youtube/v3/channels?part=id&forUsername=Google"

  # Cloud Vision API
  "https://vision.googleapis.com/v1/images:annotate"

  # Google Maps Geocoding
  "https://maps.googleapis.com/maps/api/geocode/json?address=New+York"

  # Google Translate API
  "https://translate.googleapis.com/language/translate/v2?q=Hello&target=es"

  # Custom Search API
  "https://www.googleapis.com/customsearch/v1?q=test"

  # Google Drive API
  "https://www.googleapis.com/drive/v3/about?fields=*"

  # Google Calendar API
  "https://www.googleapis.com/calendar/v3/users/me/calendarList"

  # Google People API
  "https://people.googleapis.com/v1/people/me?personFields=names,emailAddresses"

  # BigQuery API
  "https://www.googleapis.com/bigquery/v2/projects"

  # Cloud Functions API
  "https://cloudfunctions.googleapis.com/v1/projects/-/locations/-/functions"

  # Cloud Run Admin API
  "https://run.googleapis.com/v1/projects/-/locations/-/services"

  # Google Cloud Storage API
  "https://storage.googleapis.com/storage/v1/b"

  # Google Cloud Logging API (Logging Admin)
  "https://logging.googleapis.com/v2/projects/-/logs"

  # Cloud SQL Admin API
  "https://sqladmin.googleapis.com/sql/v1beta4/projects/-/instances"

  # Service Management API
  "https://servicemanagement.googleapis.com/v1/services"

  # Service Usage API
  "https://serviceusage.googleapis.com/v1/services"

  # Google Cloud APIs Discovery
  "https://www.googleapis.com/discovery/v1/apis"

  # Dataform API
  "https://dataform.googleapis.com/v1beta1/projects/-/locations/-/repositories"

  # Cloud Pub/Sub API
  "https://pubsub.googleapis.com/v1/projects/-/topics"

  # Cloud Monitoring API
  "https://monitoring.googleapis.com/v3/projects/-/alertPolicies"

  # Artifact Registry API
  "https://artifactregistry.googleapis.com/v1/projects/-/locations/-/repositories"

  # Firebase Realtime Database API
  "https://firebase.googleapis.com/v1beta1/projects/-/databases"

  # Firebase Cloud Messaging
  "https://fcm.googleapis.com/fcm/send"

  # Identity Toolkit API (Identity Platform)
  "https://identitytoolkit.googleapis.com/v3/relyingparty/getProjectConfig"

  # Cloud Build API
  "https://cloudbuild.googleapis.com/v1/projects/-/builds"

  # IAM API
  "https://iam.googleapis.com/v1/projects/-/serviceAccounts"

)

echo "Testing API key: $API_KEY"
echo

for URL in "${APIS[@]}"; do
  FULL_URL="${URL}&key=${API_KEY}"

  # Adjust if URL already has a '?'
  if [[ "$URL" == *"?"* ]]; then
    FULL_URL="${URL}&key=${API_KEY}"
  else
    FULL_URL="${URL}?key=${API_KEY}"
  fi

  echo "Testing: $FULL_URL"

  HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$FULL_URL")

  if [[ "$HTTP_CODE" == "200" ]]; then
    echo "  --> ✅ API Responded (200 OK)"
  elif [[ "$HTTP_CODE" == "400" ]]; then
    echo "  --> ⚠️  API rejected bad input (likely enabled)"
  elif [[ "$HTTP_CODE" == "403" ]]; then
    echo "  --> ❌ Forbidden (API disabled or restricted)"
  elif [[ "$HTTP_CODE" == "404" ]]; then
    echo "  --> ❌ Not found (API likely disabled)"
  else
    echo "  --> ❓ Unknown HTTP response: $HTTP_CODE"
  fi

  echo
done
