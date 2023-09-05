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
#### Testing 

Use Postman or other tools to make HTTP Request to your http://localhost:8080/. 

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
````
