# GETGOODS - Local Marketplace Application
A platform for new merchants and farmers to sell local and processed products, offering benefits, expanding customer base, and protecting against competition.

## Getting Started
To get started with the GetGoods app, follow these steps
- Download and unzip the zip file source code or clone the Haan R Haan repository: git clone
`https://github.com/boss4848/getgoods.git`

## Prerequisites
Before running the app, make sure you have the following installed:
- .env file Please make sure that you have file named config.env (frontend and backend)
- front_end/config.env
```
BASE_URL=http://<IP>:8000/api/v1
LOCAL_HOST=127.0.0.1

#android emulator (Change IP_ADDRESS to your local IP address)
IP_ADDRESS=

#stripe
STRIPE_PUBLISHABLE_KEY=
```
- back_end/config.env
```
PORT=8000

#MongoDB (Database Server)
DATABASE=
DATABASE_PASSWORD=

#JWT
JWT_SECRET=
JWT_EXPIRES_IN=1d

#Azure Storage (Image Storage Server)
AZURE_STORAGE_CONNECTION_STRING==

#Stripe (Payment Gateway)
STRIPE_SECRET_KEY=
```
- Flutter SDK version 3.7.0-0 or higher.
- Dart SDK version 2.19.3 or higher.
- Node JS

## Running the app
Once you have the prerequisites set up, you can run the app:
1. Change directory to `back_end` and then run the following commands:
```
npm i
npm start
```
2. Change directory to `front_end` and then run the following command:
```
flutter pub get
```
3. Run the app on a simulator or connected device using the following
```
flutter run
```

## Front End Dependencies
- cached_network_image
- carousel_slider
- cupertino_icons
- custom_refresh_indicator
- dio
- fl_chart
- flutter_dotenv
- flutter_spinkit
- flutter_svg
- http
- http_parser
- image
- image_picker
- intl
- patterns_canvas
- path_provider
- percent_indicator
- shared_preferences
- timeago
- socket_io_client
- flutter_rating_bar
- stripe_checkout

## Back End Dependencies
- @azure/storage-blob
- bcryptjs
- chalk
- cors
- dotenv
- express
- http
- jsonwebtoken
- mongoose
- morgan
- multer
- sharp
- socket.io
- stripe
- validator

## Tech Stack
- Flutter.
- MVVM (Model-View-ViewModel): Architectural pattern for the frontend.
- Node.js.
- Express.
- MongoDB.
- Mongoose.
- MVC (Model-View-Controller): Architectural pattern for the backend.
- Socket.io

## Cloud Storage
Azure Cloud Storage Blob (used for images)
Atlas MongoDB Cloud (used for database storage)

## Base API URL
The base API URL for the backend is 
```
http://localhost:8000/api/v1.
```