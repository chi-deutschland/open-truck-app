# OpenTruck

ONE Record based Open Source Trucking app

#
## Key features

- Assigning a piece to a truck by scanning the ONE Record URI label of the piece with the app

- Access to **any** linked data and necessary documents for all stakeholders in real time

- Photos of the piece made in the app are assigned to the piece and easily accessible for all parties in need thereof

- Real time geotracking enabling easier management through arrival prediction

- No need for filling paper and no delays, the required information of the driver are already provided in the app

- Open Truck Backend can be found here [OpenTruck-backend](https://github.com/chi-deutschland/open-truck-backend)

#
## Screenshots

- Overview screen with Truck details, live location tracking with marked locations on map for source and destination
 ![Screenshot](/images/overview.jpeg)
 
- For trucker to start loading process
 ![Screenshot](/images/loading_screen.jpeg)
 
- Machine Learning based QR code scanner to intelligently retrieve all URI info and piece details
 ![Screenshot](/images/qr_code_scanner.jpeg)
 
- Piece details information retrived from the ONE record servers
 ![Screenshot](/images/piece_details.jpeg)
 
- Taking a photo for uploading to ONE Record servers and finishing journey
 ![Screenshot](/images/take_photo.jpeg)

- Driver details which can be uploaded to the ONE Record servers to be visible to all interested parties
 ![Screenshot](/images/settings.jpeg)

#
## Running the Open Truck App
This project is a Flutter application, which can be compiled for both Android and iOS platforms

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Please dont forget to add the Google Maps API key in the  ...android/app/main/AndroidManifest.xml file and also the  ...lib/widgets/tour_details_card.dart file.
More information can be found here [Getting started with Google Maps Platform](https://developers.google.com/maps/gmp-get-started)




