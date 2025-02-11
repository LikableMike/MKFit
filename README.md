<p align="center">
  <img src="https://github.com/LikableMike/MKFit/blob/main/assets/images/tonneitup_resize.png" />
</p>   



# TonneItUp
This application will facilitate communication between trainers and  clients, simplifying the tracking progress; our goal is not to replace existing apps like MyFitnessPal, but to complement them. 
By focusing on monitoring BMI, updating progress photos, introducing new workout routines, and maintaining transparency, trainers can easily monitor their clients' exercises, track their progress over time, and make necessary adjustments to their exercise routines. Through our work, we strive to satisfy and improve the workout experience for trainers and clients. 
This application is designed to strengthen the bond between trainers and clients, providing personalized support tailored to each individual’s fitness objectives. By incorporating features that emphasize accountability and interaction, we aim to create a motivating and supportive platform that promotes long-term success.  


## Table of Contents
---
- [Table of Contents](#table-of-contents)
- [Team Members](#team-members)
- [Background](#background)
- [Solution](#solution)
- [Screenshots](#screenshots)
- [Testing](#testing)
- [Deployment](#deployment)
- [Developer Instructions](#developer-instructions)
- [Timeline](#timeline)


## Team Members
---
- [Stephanie Nutter](https://github.com/S-nutter)
- [Michael Partridge](https://github.com/LikableMike)
- [Ramin Selseleh](https://github.com/RaminSel)
- [Christian Vela Pasillas](https://github.com/christianvelapasill)
- [Phillip Avila](https://github.com/APEX226)
- [Nicholas Gaudet](https://github.com/ng262)
- [Isaiah Samaniego](https://github.com/IsaiahSami)
- [Brian Hert](https://github.com/BrianHert)



## Background
---

Makayla is an independent personal trainer based out of Woodland California. Her training business TonneItUp provides one-on-one training in physical fitness for people of all ages. Makayla often works through her local gym to find clients who are looking to start their workout journey and assists in finding the right exercises for them.  Furthermore, she offers dietary advice so that customers achieve the greatest results possible.


## Solution
---
Embarking on a fitness journey to become the best version of yourself is no small feat. It demands discipline, consistency, and unwavering commitment to achieve meaningful results. To better support Makayla's clients in reaching their fitness goals and staying motivated, we developed a mobile application designed to enhance engagement and keep clients actively connected to their fitness plans between appointments. 

The app offers the following features: 

- **Enhanced Client Interaction:** Makayla can engage with her clients directly through the app, fostering a stronger coach-client connection.
- **Access to Personalized Workout Plans:** Users can follow workout routines prescribed by Makayla at their convenience, promoting self-driven progress.
- **Progress Tracking:** A dedicated progress page allows clients to monitor their weight and BMI, keeping them focused on their goals.
- **Streamlined Appointment Management:** An integrated appointment page enables users to easily view upcoming sessions and cancel them when needed.

With this app, Makayla's clients can stay motivated, track their progress, and remain fully engaged in their fitness journey.

Vision and Impact

The development of TonneItUp is driven by a vision to bridge the gap between personal trainers and their clients, making fitness journeys more engaging and personalized. This application is not just a tool but a companion that empowers users to embrace healthier lifestyles through consistent communication, tailored routines, and actionable insights.

Our goal is to foster a sense of accountability and motivation by leveraging technology to create an environment where clients feel supported every step of the way. Beyond the immediate benefits of tracking progress and managing appointments, TonneItUp aspires to:

Promote Sustainable Habits: Encourage clients to adopt and maintain long-term fitness practices by integrating regular updates and reminders.
Enhance Accessibility: Provide trainers and clients with a seamless interface that reduces the barriers to effective communication and fitness management.
Support the Fitness Community: Serve as a model for future applications that prioritize holistic well-being, addressing both physical and mental health.
By focusing on these aspirations, TonneItUp aims to redefine the standard for trainer-client relationships in the fitness industry, setting a precedent for future innovations that prioritize user engagement and satisfaction.

## Screenshots
---
![image](https://github.com/user-attachments/assets/6aa11325-bd63-4655-bf44-390b53bd9f6c)
![image](https://github.com/user-attachments/assets/e57655eb-509d-4fc6-89e8-957c3764bc4b)
![image](https://github.com/user-attachments/assets/e8d17213-1e1b-431d-aa4e-0a24cade7e58)
![image](https://github.com/user-attachments/assets/19e9ecb1-e0da-4e5e-9c94-3dc1f7d78a24)
![image](https://github.com/user-attachments/assets/8fadeeb5-4f87-4708-9999-d0c2a75c38e2)
![image](https://github.com/user-attachments/assets/55f6f084-3551-4ba9-b1f1-145652d96dd1)



## Testing
---
This sections outlines the testing framework and instructions for running tests to ensure application functionality.
Testing for this application is done manually. To quickly verify that the system is still working after changes, identify the affected components and ensure all features, such as navigation and text entry, still function. Backend functionality can be tested by reviewing runtime logs seen in the terminal when running the app.
Key areas are tested by verifying functionality through normal use cases. Efficiency and speed were tested through examining response times, data processing, transitions between app features, and how responsive the user interface is.



## Developer Instructions
---
To run this code, developers must download the latest versions of Dart/Flutter and Java, as well as Android Studio.  
<a href="https://developer.android.com/studio">Android Studio</a>

<a href="https://dart.dev/get-dart">Dart SDK</a>

<a href="https://docs.flutter.dev/get-started/install">Flutter SDK</a>

<a href="https://www.openlogic.com/openjdk-download">A compatible Java Development Kit.</a>

At the time of this writing, JDK 8 or JDK 11 are compatible with Android Studio.

Upon downloading the project, the developer must setup their SDK manager within Android Studio. To do so, click on "SDK Manager" from the toolbar.  You will need to add a Flutter and Dart framework based upon its downloaded location.

Users must also set their Java Development kit and Java_PATH files in their environmental variables by searching "environment" in your device's search bar and clicking "Environmental Variables." 
In this menu, you must edit the "System Variables" and add a variable named JAVA_HOME.  This variable should point to your JDK 8 or (preferably) JDK 11 folder.

In order to utilize Android Studio's development tools, you must use its built-in emulator.  On the right of the progam, there is an icon named "Device Manager." Through this manager, you will download an emulator for your selected phone.
Testing will be done using this emulator.  You can run it at any time using the trianguar "play" button.

With Android Studio's environment set up properly and the emulator downloaded, you will be able to run the project. Run it using the triangular "play" button on the top bar or by typing "flutter run" in the terminal window; if you have an emulator open it will automatically select the device for you.

Ensure that the Flutter and Dart SDK paths are properly configured in Android Studio to prevent runtime errors. Verify that the emulator settings align with the application's target API level for accurate simulation. Whenever possible, test the application on physical devices to assess performance and compatibility in real-world scenarios. To streamline development, use Flutter's "Hot Reload" feature to instantly reflect changes in the application without rebuilding the project.

## Deployment
---

Prerequisites:
 - Developer accounts for app stores (Google Play Developer and Apple Developer).
 - Tools and environment setup (Flutter SDK, Android Studio, Xcode).

Steps for Android Deployment:
 - Preparing the app for release (updating version numbers and metadata).
 - Generating a signed APK (the Android app package).
 - Uploading the app to the Google Play Console and submitting it for review.

Steps for iOS Deployment:
 - Preparing the app (configuring project files and signing certificates).
 - Archiving the build in Xcode.
 - Uploading to App Store Connect and submitting it for review.

Testing Before Release:
 - Ensuring the app works correctly on both platforms through emulators and real devices.

Post-Deployment:
Monitoring app performance and user feedback.
Submitting updates or fixes as needed.

Compliance:
 - Ensure the app adheres to app store policies, including user privacy and data handling, to avoid review rejections.
 - Verify that all required permissions are clearly explained and justified to users during app use.
 - Include clear disclaimers or consent forms for collecting sensitive data, ensuring compliance with regulations such as GDPR, CCPA, or other applicable laws.


## Timeline
---
<b>February 2024:</b> Charter completion and project confirmation.

<b>March 2024:</b> Base Flutter demo completion.

<b>April 2024:</b> Began front end with account creation, login, and password pages.

<b>May 2024:</b> Functional front end for users nearing completion. Front page integration, ability to view workouts as a PDF, calendars.

<b>September 2024:</b> Database implementation completed, back end work begins.

<b>October 2024:</b> Settings, Account, and Appointment development begins. Admin features, such as Daily Motivation, Create Exercise, and Create Workout development begin.

<b>November 2024</b> Appointment functions refined and tested. Chat function work begins. Functional testing begins.

<b>Early December 2024:</b> Project completed and given to client.
