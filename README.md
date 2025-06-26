# gcp_tools
scripts for testing GCP


Some of these are AI-generated, sorry. I make no guarantees on any of this. Consider it alpha release.


## test_google_api_key.sh
This tool is meant to test Google API keys (googleapis.com).  Not 100% on all these endpoints. I'll test more thoroughly later but it's a start at least. And don't bother, the API key below is no longer valid.

```
./test_google_api_key.sh "AIzaSyAto14TGTMaftaxdK6AwAFgAmt7eO7ietk"
Testing API key: AIzaSyAto14TGTMaftaxdK6AwAFgAmt7eO7ietk

Testing: https://www.googleapis.com/geolocation/v1/geolocate?key=AIzaSyAto14TGTMaftaxdK6AwAFgAmt7eO7ietk
  --> ❌ Not found (API likely disabled)

Testing: https://www.googleapis.com/youtube/v3/channels?part=id&forUsername=Google&key=AIzaSyAto14TGTMaftaxdK6AwAFgAmt7eO7ietk
  --> ❌ Forbidden (API disabled or restricted)

Testing: https://vision.googleapis.com/v1/images:annotate?key=AIzaSyAto14TGTMaftaxdK6AwAFgAmt7eO7ietk
  --> ❌ Not found (API likely disabled)

Testing: https://maps.googleapis.com/maps/api/geocode/json?address=New+York&key=AIzaSyAto14TGTMaftaxdK6AwAFgAmt7eO7ietk
  --> ✅ API Responded (200 OK)

Testing: https://translate.googleapis.com/language/translate/v2?q=Hello&target=es&key=AIzaSyAto14TGTMaftaxdK6AwAFgAmt7eO7ietk
  --> ❌ Forbidden (API disabled or restricted)

Testing: https://www.googleapis.com/customsearch/v1?q=test&key=AIzaSyAto14TGTMaftaxdK6AwAFgAmt7eO7ietk
  --> ❌ Forbidden (API disabled or restricted)

Testing: https://www.googleapis.com/drive/v3/about?fields=*&key=AIzaSyAto14TGTMaftaxdK6AwAFgAmt7eO7ietk
  --> ❓ Unknown HTTP response: 401

Testing: https://www.googleapis.com/calendar/v3/users/me/calendarList?key=AIzaSyAto14TGTMaftaxdK6AwAFgAmt7eO7ietk
  --> ❓ Unknown HTTP response: 401

Testing: https://people.googleapis.com/v1/people/me?personFields=names,emailAddresses&key=AIzaSyAto14TGTMaftaxdK6AwAFgAmt7eO7ietk
  --> ❌ Forbidden (API disabled or restricted)

Testing: https://www.googleapis.com/bigquery/v2/projects?key=AIzaSyAto14TGTMaftaxdK6AwAFgAmt7eO7ietk
  --> ❓ Unknown HTTP response: 401

Testing: https://cloudfunctions.googleapis.com/v1/projects/-/locations/-/functions?key=AIzaSyAto14TGTMaftaxdK6AwAFgAmt7eO7ietk
  --> ❓ Unknown HTTP response: 401

Testing: https://run.googleapis.com/v1/projects/-/locations/-/services?key=AIzaSyAto14TGTMaftaxdK6AwAFgAmt7eO7ietk
  --> ❓ Unknown HTTP response: 401

Testing: https://storage.googleapis.com/storage/v1/b?key=AIzaSyAto14TGTMaftaxdK6AwAFgAmt7eO7ietk
  --> ⚠️  API rejected bad input (likely enabled)

Testing: https://logging.googleapis.com/v2/projects/-/logs?key=AIzaSyAto14TGTMaftaxdK6AwAFgAmt7eO7ietk
  --> ❌ Not found (API likely disabled)

Testing: https://sqladmin.googleapis.com/sql/v1beta4/projects/-/instances?key=AIzaSyAto14TGTMaftaxdK6AwAFgAmt7eO7ietk
  --> ❓ Unknown HTTP response: 401

Testing: https://servicemanagement.googleapis.com/v1/services?key=AIzaSyAto14TGTMaftaxdK6AwAFgAmt7eO7ietk
  --> ✅ API Responded (200 OK)

Testing: https://serviceusage.googleapis.com/v1/services?key=AIzaSyAto14TGTMaftaxdK6AwAFgAmt7eO7ietk
  --> ❌ Forbidden (API disabled or restricted)

Testing: https://www.googleapis.com/discovery/v1/apis?key=AIzaSyAto14TGTMaftaxdK6AwAFgAmt7eO7ietk
  --> ✅ API Responded (200 OK)

Testing: https://dataform.googleapis.com/v1beta1/projects/-/locations/-/repositories?key=AIzaSyAto14TGTMaftaxdK6AwAFgAmt7eO7ietk
  --> ❓ Unknown HTTP response: 401

Testing: https://pubsub.googleapis.com/v1/projects/-/topics?key=AIzaSyAto14TGTMaftaxdK6AwAFgAmt7eO7ietk
  --> ❌ Forbidden (API disabled or restricted)

Testing: https://monitoring.googleapis.com/v3/projects/-/alertPolicies?key=AIzaSyAto14TGTMaftaxdK6AwAFgAmt7eO7ietk
  --> ❓ Unknown HTTP response: 401

Testing: https://artifactregistry.googleapis.com/v1/projects/-/locations/-/repositories?key=AIzaSyAto14TGTMaftaxdK6AwAFgAmt7eO7ietk
  --> ❌ Forbidden (API disabled or restricted)

Testing: https://firebase.googleapis.com/v1beta1/projects/-/databases?key=AIzaSyAto14TGTMaftaxdK6AwAFgAmt7eO7ietk
  --> ❌ Not found (API likely disabled)

Testing: https://fcm.googleapis.com/fcm/send?key=AIzaSyAto14TGTMaftaxdK6AwAFgAmt7eO7ietk
  --> ❌ Not found (API likely disabled)

Testing: https://identitytoolkit.googleapis.com/v3/relyingparty/getProjectConfig?key=AIzaSyAto14TGTMaftaxdK6AwAFgAmt7eO7ietk
  --> ❌ Not found (API likely disabled)

Testing: https://cloudbuild.googleapis.com/v1/projects/-/builds?key=AIzaSyAto14TGTMaftaxdK6AwAFgAmt7eO7ietk
  --> ❓ Unknown HTTP response: 401

Testing: https://iam.googleapis.com/v1/projects/-/serviceAccounts?key=AIzaSyAto14TGTMaftaxdK6AwAFgAmt7eO7ietk
  --> ❌ Forbidden (API disabled or restricted)
```
