# Scan Master

## Overview

Scan Master is a comprehensive QR and Bar code scanning application developed using Flutter. This project leverages GetX for state management and Hive for local storage, providing an efficient and user-friendly experience for scanning, storing, and managing QR and bar codes. This application was developed as part of my internship to showcase my ability to deliver a fully functional, industry-standard mobile application.

## Features

- **QR and Bar Code Scanning**: Utilize the device camera to scan QR or Bar codes seamlessly.
- **Scan History Management**: Store and view previously scanned QR codes with timestamps.
- **Customizable Settings**: Toggle various settings including dark mode, auto-detect, and more.
- **Flashlight Control**: Adjust flashlight settings manually or set it to auto mode based on ambient light.
- **Gallery Import**: Import images from the gallery to scan for QR codes.
- **Context-Aware Actions**: Execute actions based on the content of the QR code (e.g., open URLs, send emails, etc.).

## Installation

### Prerequisites

- **Flutter SDK**: [Install Flutter](https://flutter.dev/docs/get-started/install)
- **Dart SDK**: Included with Flutter installation
- **Git**: [Install Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

### Steps

1. **Clone the Repository**
    ```bash
    git clone https://github.com/Aj3322/CODECLAUSE/tree/main/scan_master
    cd scan_master
    ```

2. **Install Dependencies**
    ```bash
    flutter pub get
    ```

3. **Run the App**
    ```bash
    flutter run
    ```

## Usage

### Main Features

- **Scanning QR Codes**: Launch the app and point the camera towards a QR code to scan it.
- **Viewing Scan History**: Access the history of scanned QR codes through the History section.
- **Managing Settings**: Navigate to the Settings section to customize your preferences.
- **Using Flashlight**: Toggle the flashlight on/off or set it to auto mode.
- **Importing from Gallery**: Select an image from your gallery to scan for QR codes.

### In-App Navigation

- **Home Screen**: Displays the QR scanner.
- **Drawer Menu**: Access History, Settings, and About sections.
- **History View**: Lists all previously scanned QR codes.
- **Settings View**: Customize various app settings.

## Project Structure

```plaintext
lib/
├── controllers/
│   ├── scan_controller.dart
│   ├── history_controller.dart
│   └── settings_controller.dart
├── models/
│   └── scan_model.dart
├── services/
│   └── storage_service.dart
├── views/
│   ├── scan_view.dart
│   ├── history_view.dart
│   └── settings_view.dart
├── main.dart
└── routes.dart
```

## Dependencies

- `flutter`: SDK for building mobile applications
- `get`: GetX for state management and dependency injection
- `hive`: Lightweight and fast key-value database
- `hive_flutter`: Flutter integration for Hive
- `permission_handler`: For managing app permissions
- `qr_code_scanner`: For scanning QR codes
- `image_picker`: For picking images from the gallery
- `url_launcher`: For launching URLs, emails, etc.
- `light`: For managing light sensor data
- `path_provider`: For accessing device paths
- `flutter_launcher_icons`: For generating app icons
- `flutter_localizations`: For localization support
- `shared_preferences`: For storing simple key-value pairs

## pubspec.yaml

```yaml
name: scan_master
description: A new Flutter project.
publish_to: 'none' # Remove this line if you wish to publish to pub.dev

version: 1.0.0+1

environment:
  sdk: '>=3.2.3 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
  get:
  qr_code_scanner:
  hive:
  hive_flutter:
  path_provider:
  permission_handler:
  flutter_launcher_icons:
  flutter_localizations:
    sdk: flutter
  url_launcher: ^6.2.6
  image_picker: ^1.0.8
  qr_code_utils: ^0.0.1
  light: ^3.0.1
  shared_preferences: ^2.2.3

dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: ^2.1.7
  hive_generator: ^1.1.1
  flutter_lints: ^2.0.0

flutter:
  uses-material-design: true
```

## Ui 


<img src="https://github.com/Aj3322/CODECLAUSE/assets/114848454/e365376f-8096-4482-af54-989ab818aa41" height="400" width="200">
<img src="https://github.com/Aj3322/CODECLAUSE/assets/114848454/b8d7b7f6-85e0-44b3-93c8-f07975c44f15" height="400" width="200">
<img src="https://github.com/Aj3322/CODECLAUSE/assets/114848454/45b2f7f9-80b5-4f8a-b172-2035b0d05c4a" height="400" width="200">
<img src="https://github.com/Aj3322/CODECLAUSE/assets/114848454/8b600b60-93fa-4b69-a886-26428a9e7472" height="400" width="200">
<img src="https://github.com/Aj3322/CODECLAUSE/assets/114848454/673afd72-7ab7-4d90-8b01-f038dd258d37" height="400" width="200">
<img src="https://github.com/Aj3322/CODECLAUSE/assets/114848454/6f57417f-f569-4c6d-b5ac-ffb1edeb465c" height="400" width="200">


## Contributions

Contributions to this project are welcome. If you find any issues or have suggestions for improvements, please open an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## Acknowledgements

- Thanks to my internship mentors for their guidance and support.
- Special thanks to the Flutter community for their extensive resources and assistance.
