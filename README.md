![](./assets/mango.jpg)

# ***mango-rider***
[![GitHub labels](https://img.shields.io/github/labels/atom/atom/help-wanted)](mailto:runrteam@gmail.com)
[![All Contributors](https://img.shields.io/github/contributors/davidionita/mango.svg)](https://github.com/davidionita/mango/graphs/contributors/)
[![GitHub closed issues](https://img.shields.io/github/issues-closed/davidionita/mango.svg)](https://github.com/davidionita/mango/issues)
[![Flutter](https://img.shields.io/badge/framework-Flutter-blue)](https://flutter.dev/)
[![Platforms supported](https://img.shields.io/badge/platform-ios%20%3E%3D%2010.0%20%7C%20android%20%20%3E%3D%204.1-lightgrey)]()
[![Discord](https://img.shields.io/discord/691477276453240863.svg?label=&logo=discord&logoColor=ffffff&color=7389D8&labelColor=6A7EC2)](https://discord.gg/XEyGCkb)
[![Star on GitHub](https://img.shields.io/github/stars/davidionita/mango.svg?style=social)](https://github.com/davidionita/mango/stargazers)

A new type of ridesharing app.

This is the rider-only app.

If you would like to join the team, please contact one of the contributors *or* email [**runrteam@gmail.com**](mailto:runrteam@gmail.com).

# getting started

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view the [online documentation](https://flutter.dev/docs), which offers a quick start guide, tutorials, samples, guidance on mobile development, and a full API reference.

# project enviornment setup

#### all platforms

Make sure to run `$ flutter pub get` after navigating to your project directory.  This will install all dependencies from `pubspec.yaml`.

Create a `.env` file in your project root with a single line in it: `GOOGLE_MAPS_API_KEY=_______________`.

Then insert a Google Maps API key in this `.env` file after the equal sign.

#### ios only

If you are planning on using an iOS device/simulator to test the app, please run `.gitconfig.sh` after filling out the `.env` file.  This will automatically insert the API key into your AppDelegate.swift and ensure the API key is not commited to Git.

Note: You must run `.gitconfig.sh` each time you clone (*not* pull or checkout, but **clone**) the repository as it edits your local/project Git config files.

#### android only

If you are planning on using an Android device/simulator to test the app, please follow [**this**](https://developers.google.com/android/guides/client-auth) guide to get the SHA-1 of your signing certificate.  Once you have obtained this, please send it to one of the contributors *or* email [**runrteam@gmail.com**](mailto:runrteam@gmail.com) so we can add it to the Firebase console.  

Note: This is necessary to authenticate using Google Sign-In on Android during development.  Otherwise, your app will crash after clicking `Google Sign-In` on the app login page.

# [teams](https://github.com/davidionita/mango/projects)

### [Business](https://github.com/davidionita/mango/projects/8)

Secretarial and managerial duties that plan for the future of the app.

### [Backend](https://github.com/davidionita/mango/projects/7)

Configuring Firebase and integrating it into the Flutter app.

### [Frontend](https://github.com/davidionita/mango/projects/1)

Building the UI and making it a beauty!

