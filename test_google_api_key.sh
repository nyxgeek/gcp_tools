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

# Function to test an API endpoint and print results, including the entire response body for non-200 codes
test_api_endpoint() {
  local URL="$1"
  local FULL_URL=""

  # Adjust if URL already has a '?'
  if [[ "$URL" == *"?"* ]]; then
    FULL_URL="${URL}&key=${API_KEY}"
  else
    FULL_URL="${URL}?key=${API_KEY}"
  fi

  echo "Testing: $FULL_URL"

  # Capture both HTTP code and response body
  # -s: Silent mode
  # -w %{http_code}\n: Prints HTTP code followed by a newline to stdout after the body
  # -D /dev/stderr: Redirects headers to stderr to keep stdout clean for body+code
  RESPONSE_OUTPUT=$(curl -s -w "%{http_code}\n" "$FULL_URL")

  # Extract HTTP code (last line of RESPONSE_OUTPUT)
  HTTP_CODE=$(echo "$RESPONSE_OUTPUT" | awk 'END{print}')

  # Extract response body (all lines except the last one which is the HTTP code)
  RESPONSE_BODY=$(echo "$RESPONSE_OUTPUT" | sed '$d')

  # Check HTTP code and provide appropriate message
  if [[ "$HTTP_CODE" == "200" ]] &&  ! echo "$RESPONSE_BODY" | grep -qi 'error_message' && \
     ! echo "$RESPONSE_BODY" | grep -iq 'errorMessage' && ! echo "$RESPONSE_BODY" | grep -qi 'API_KEY_INVALID' && \
     ! echo "$RESPONSE_BODY" | grep -iq '"error"'; then
	    echo "  --> ✅ API Responded (200 OK)"
	    # Optionally print body for truly successful
	    # If you want to see the body even on successful 200, uncomment the line below:
	    #echo "      Response Body: $RESPONSE_BODY"
  else
    # For any non-200 HTTP code, check for specific error messages in the body
    if echo "$RESPONSE_BODY" | grep -q "API key expired."; then
      echo "  --> ❌ API Key Expired (HTTP $HTTP_CODE)"
    elif echo "$RESPONSE_BODY" | grep -q "API_KEY_INVALID"; then
      echo "  --> ❗ API Key Revoked. Invalid Key. (HTTP $HTTP_CODE)"
    elif echo "$RESPONSE_BODY" | grep -q "SERVICE_DISABLED"; then
      echo "  --> ⚠️  Service disabled (can be enabled via Console link in message) (HTTP $HTTP_CODE)"
    elif echo "$RESPONSE_BODY" | grep -q "This API project is not authorized to use this API."; then
      echo "  --> ❌ API project not authorized for this API (HTTP $HTTP_CODE)"
    elif echo "$RESPONSE_BODY" | grep -q "calling a legacy API"; then
      echo "  --> ❌ Legacy API is not enabled (HTTP $HTTP_CODE)"
    elif echo "$RESPONSE_BODY" | grep -q "API keys are not supported by this API."; then
      echo "  --> ❌ API keys are not supported by this API (HTTP $HTTP_CODE)"
    elif echo "$RESPONSE_BODY" | grep -q "Project does not exist"; then
      echo "  --> ⚠️ Project does not exist (A project must be specified for this API). Consider using gobuster or similar for project discovery. (HTTP $HTTP_CODE)"
    else
      # Fallback to generic HTTP code messages if no specific string is matched
      if [[ "$HTTP_CODE" == "400" ]]; then
        echo "  --> ⚠️  API rejected bad inpu (HTTP $HTTP_CODE)t"
      elif [[ "$HTTP_CODE" == "401" ]]; then
        echo "  --> ❓ Unauthorized (API likely requires OAuth/Service Account - HTTP $HTTP_CODE)"
      elif [[ "$HTTP_CODE" == "403" ]]; then
        echo "  --> ❌ Forbidden (API disabled or restricted - HTTP $HTTP_CODE)"
      elif [[ "$HTTP_CODE" == "404" ]]; then
        echo "  --> ❌ Not found (API likely disabled - HTTP $HTTP_CODE)"
      else
        echo "  --> ❓ Unknown HTTP response : $HTTP_CODE"
      fi
    fi
    #echo "      Response Body:"
    #echo "$RESPONSE_BODY" # Always print the full response body for non-200 cases
  fi

  echo # Empty line for readability
}

APIS=(
  # Original Endpoints
  # Geolocation API
  "https://www.googleapis.com/geolocation/v1/geolocate"

  # YouTube Data API
  "https://www.googleapis.com/youtube/v3/channels?part=id&forUsername=Google"

  # Cloud Vision API
  "https://vision.googleapis.com/v1/images:annotate"

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

  # --- Additional Google Maps Platform APIs (often work with API Key, but some might need billing enabled) ---
  "https://maps.googleapis.com/maps/api/place/textsearch/json?query=restaurants+in+New+York"
  "https://maps.googleapis.com/maps/api/distancematrix/json?origins=Vancouver|San+Francisco&destinations=Victoria|Seattle"
  "https://maps.googleapis.com/maps/api/elevation/json?locations=39.7391536,-104.9847034"
  "https://maps.googleapis.com/maps/api/timezone/json?location=39.603481,-105.050303&timestamp=1458888000"

  # --- Google Workspace APIs (Highly likely to require OAuth 2.0 for actual data) ---
  # Note: These will almost certainly return 401 or 403 with just an API key.
  # For Sheets/Docs, a specific ID is usually required for content access.
  "https://www.googleapis.com/gmail/v1/users/me/profile"
  "https://sheets.googleapis.com/v4/spreadsheets"
  "https://docs.googleapis.com/v1/documents"

  # --- Google Admin SDK APIs (Highly likely to require OAuth 2.0 and Admin privileges) ---
  # These are for managing Google Workspace domains and users. API key alone is insufficient.
  "https://admin.googleapis.com/admin/directory/v1/users"

  # --- Other Core Google Cloud APIs (likely require OAuth/Service Account for access) ---
  # These typically need project-level authentication beyond just an API key.
  # The use of '-' for project/location/zone is common for listing resources the authenticated user can see.
  "https://compute.googleapis.com/compute/v1/projects/-/zones"
  "https://container.googleapis.com/v1/projects/-/zones/-/clusters"
  "https://dataproc.googleapis.com/v1/projects/-/regions/-/clusters"
  "https://secretmanager.googleapis.com/v1/projects/-/secrets"
  "https://datastore.googleapis.com/v1/projects/-:runQuery"
)

echo "Testing API key: $API_KEY"
echo "------------------------------------------------------------"

for URL in "${APIS[@]}"; do
  test_api_endpoint "$URL"
done

echo "------------------------------------------------------------"
echo "Testing complete."
