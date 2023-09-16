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
5. Move .env file containing environment variables to /frontend directory (root folder of frontend) 


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

To run app:
````
mvn spring-boot:run
````
## Testing 

### Test Backend Endpoints
Use Postman or other tools to make HTTP Request to your http://localhost:8080/, after running the Spring Boot Server app.

#### Pre-Requisites
- MySQL
- IDE with Java Maven environment configured (IntelliJ, VSCode, etc.)
- Postman or endpoint testing tool of your choice

#### Steps 

The order to test the endpoints on your own device is as follows:
1. Ensure that your MySQL database is initialized; If not, run the commands in DIPSHOP.sql in your MySQL client with an authorized user.
2. Run your MySQL server mysqld.exe with an authorized user
3. Navigate to the server root folder with your IDE (/server/dipapp)
4. Ensure that your application properties is setup; refer to [application properties](#application-properties)
5. For IntelliJ, just click on DipappApplication.java and run; For VSCode, run ``` mvn spring-boot:run ``` in your console; Ensure that no error code happens after.
6. Use Postman or any endpoint testing tool of your choice to test the endpoints

***

### Test Mobile Application
Use an emulator on your device, your web browser, or a mobile device connected to your computer to test the application

#### Pre-Requisites
- MySQL
- IDE with Java Maven environment configured (IntelliJ, VSCode, etc.)
- IDE with Flutter environment configured (Android Studios, VSCode, etc.)
- Device of choice

#### Steps 

The order to test the application on your own device is as follows:
1. Ensure that your MySQL database is initialized; If not, run the commands in DIPSHOP.sql in your MySQL client with an authorized user.
2. Run your MySQL server mysqld.exe with an authorized user
3. Navigate to the server root folder with your Java configured IDE (/server/dipapp)
4. Ensure that your application properties is setup; refer to [application properties](#application-properties)
5. For IntelliJ, just click on DipappApplication.java and run; For VSCode, run ``` mvn spring-boot:run ``` in your console; Ensure that no error code happens after.
6. Navigate to the client root folder with your Flutter Configured IDE (/frontend/lib/main.dart)
7. Depending on your device, modify the URL in main.dart to a specific URL (This will point to the ip address the Spring server is being hosted on, and will change if we host the server online)
8. Run main.dart without debugging.


***

#### Application Properties

For your Spring Boot server, add a file called 'application.properties' into resources and add the following line:
(Make sure that your MySQL server is running and already has the database 'dip' created from the .sql file) 
````
spring.datasource.url=jdbc:mysql://localhost:3306/dip
Shift=true&useLegacyDatetimeCode=false&serverTimezone=UTC
server.error.whitelabel.enabled=false
spring.datasource.username= YOUR_USERNAME_HERE
spring.datasource.password= YOUR_PASSWORD_HERE
server.port=8080
spring.jpa.hibernate.naming-strategy=org.hibernate.cfg.EJB3NamingStrategy
spring.jpa.hibernate.naming.physical-strategy=org.hibernate.boot.model.naming.PhysicalNamingStrategyStandardImpl
spring.jpa.hibernate.naming.implicit-strategy=org.hibernate.boot.model.naming.ImplicitNamingStrategyLegacyJpaImpl
jwt.secret=eyJhbGciOiJIUzI1NiJ9.eyJSb2xlIjoiQWRtaW4iLCJJc3N1ZXIiOiJJc3N1ZXIiLCJVc2VybmFtZSI6IkphdmFJblVzZSIsImV4cCI6MTY5NDAwODU2MSwiaWF0IjoxNjk0MDA4NTYxfQ.6UJXEaQc5kE8e8bmjDjnoyXYFbhFRlf7mij1I_iboYQ
jwt.expiration=36000000000
upload-dir= YOUR_DIRECTORY_HERE EXAMPLE: C:/Users/ewanh/java2/NTUMart-main/server/src/main/resources/uploads
spring.servlet.multipart.max-file-size=10MB
spring.servlet.multipart.max-request-size=10MB
````
