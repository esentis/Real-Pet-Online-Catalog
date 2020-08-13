
![alt text](https://i.imgur.com/dcVYosv.png "Real Pet inc.")

# Real Pet Online Shop Catalog

[![forthebadge](https://forthebadge.com/images/badges/built-with-love.svg)](https://forthebadge.com)

![Flutter CI](https://github.com/esentis/Real-Pet-Online-Catalog/workflows/Flutter%20CI/badge.svg)
[![Codemagic build status](https://api.codemagic.io/apps/5f347ebdb4e2d165a893e3c7/5f347ebdb4e2d165a893e3c6/status_badge.svg)](https://codemagic.io/apps/5f347ebdb4e2d165a893e3c7/5f347ebdb4e2d165a893e3c6/latest_build)

## Overview

An Android / iOS petshop catalog app made with Flutter / Dart.

## Screenshots

Login / Register| Successful login | User Page (work in progress)
------------ | -------------| ------------- |
![Login / Register](/screenshots/1.gif?raw=true "Login / Register") | ![Success login](/screenshots/2.gif?raw=true "Success login") | ![User page](/screenshots/6.gif?raw=true "User page")

Category Products |Product Page| Search Product |
------------ |------------ | -------------|
![Category products](/screenshots/3.gif?raw=true "Category products") | ![Product page](/screenshots/4.gif?raw=true "Product page") |![Search product](/screenshots/5.gif?raw=true "Search product")

## Features

>Backend is made with  EF Core and C# (repo link coming soon)

- [x] User authentication / registration with Firebase
- [x] User info editing
- [x] Product  categories
- [x] Product  page
- [x] Infinite scrolling
- [x] Search supports both Greek and English characters.
- [x] Smooth 60 FPS animations.
- [ ] Edit a product
- [ ] Add a new product
- [ ] Delete a product
- [ ] Create user roles
- [ ] Rate / review product

## Libraries

| Name        | Version           | Use case |
| :------------- |:-------------:|:-------------:|
| [firebase_core](https://pub.dev/packages/firebase_core)| ^0.4.5 | ***Firebase Core API*** |
| [firebase_auth](https://pub.dev/packages/firebase_auth)| ^0.16.1 | ***Firebase Authentication API*** |
| [cloud_firestore](https://pub.dev/packages/cloud_firestore)| ^0.13.7 | ***Cloud Firestore API*** |
| [modal_progress_hud](https://pub.dev/packages/modal_progress_hud)| ^0.1.3 | ***Loading Spinner on Async*** |
| [get](https://pub.dev/packages/get)| ^2.7.1 | ***Routing / Snackbars*** |
| [google_fonts](https://pub.dev/packages/google_fonts)| ^1.1.0 | ***Access Google Fonts*** |
| [font_awesome_flutter](https://pub.dev/packages/font_awesome_flutter)| ^8.8.1 | ***Font Awesome Icons*** |
| [flare_flutter](https://pub.dev/packages/flare_flutter)| ^2.0.3 | ***Flare Animations*** |
| [transparent_image](https://pub.dev/packages/transparent_image)| ^1.0.0 | ***Simple Transparent Image*** |
| [logger](https://pub.dev/packages/logger)| ^0.9.1 | ***Console Logger*** |
| [flutter_spinkit](https://pub.dev/packages/flutter_spinkit)| ^4.1.2+1 | ***Loading Spinners*** |
| [foldable_sidebar](https://pub.dev/packages/foldable_sidebar)| ^1.0.0| ***Foldable Drawer*** |
| [provider](https://pub.dev/packages/provider)     | ^4.3.2      | ***State Management***|
| [pedantic](https://pub.dev/packages/pedantic) | ^1.9.0     |***Static Analysis*** |
| [url_launcher](https://pub.dev/packages/url_launcher) | ^5.5.0   | ***Url Launcher***  |
| [dio](https://pub.dev/packages/dio) | ^3.0.10   | ***HTTP Requests***  |
