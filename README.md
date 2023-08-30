# NTUMart

A marketplace for NTU students, upgraded.


An improved version of existing marketplaces.

#### Before making any changes 
Remember to fetch from master branch

## Get Started 

#### For frontend
❗Pre-requisites: 
1. Flutter SDK
   - For MACOs (make sure you have homebrew installed) 
     ```
     brew install --cask flutter
     ```
  - For Windows
     Download from https://flutter.dev/docs/get-started/install 
3. Dart SDK (it's downloaded with Flutter SDK, but make sure it's on PATH)
4. Android Studio/VSCode

To get started with frontend from terminal, navigate to /frontend directory 

Install dependencies 
````
flutter pub get
````

To run application 
````
flutter run 
````
#### For backend
❗Pre-requisites: 
1. Java Development Kit (JDK)
2. Maven 

#### Get Started 
Navigate to root folder (/server/dipapp) 

In your terminal to install dependencies 
``
mvn clean package
``
To run app: replace <path/to/compiled/classes> with where the binary file of your compiled java application is. 
Usually under /server/dipapp/target/classes/com/ntumart/dipapp 
````
  java -cp <path/to/compiled/classes> com.example.demo.DipappApplication
````
#### Testing 

Use Postman or other tools to make HTTP Request to your http://localhost:8080/. 


