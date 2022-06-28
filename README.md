# Technical test digital experience version #2
 
In this repository you'll find a project which contains multiple functionalities added such as log in with phone number using firebase as the main db. you'll find to versions of the app, one which is simpler you'll see more logic than anything and on features you'll see the same app but we're applying clean arquicture on the code, separating the logic from the views this was done trought provider as the middle agent between the logic and the views.
 
Functionalities:
 
 - User log in with phone number and also verification trought phone number
 - Register using Firebase Firestore dependency
 - Maps using google maps dependency
 - Geolocation to get the current position of the user and also markers on the map
 - Geocoding added on the search bar in order to find addresses manually, map will reposition the current marker to the one that you search on the search bar
 - Use of provider trought all the app to be able to connect every information on the app

Dependencies:
 - provider: 6.0.3
 - flutter_verification_code: 1.1.3
 - geolocator: 8.2.1
 - geocoding: 2.0.4
 - google_maps_flutter: 2.1.7
 - firebase_auth: 3.3.19
 - fluttertoast: 8.0.9
 - firebase_core: 1.17.1
 - cloud_firestore: 3.1.17
