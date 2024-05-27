# Social Media App

## Overview

Social Media App is a comprehensive mobile application developed using Flutter, aimed at providing users with a seamless and engaging social media experience. Built with scalability and performance in mind, this project showcases the integration of modern cross-platform technologies including Flutter, GetX for state management, and Hive for local storage. With features ranging from user authentication to post creation, messaging, notifications, and more, Social Media App demonstrates my ability to deliver robust and user-centric mobile applications.

## Features

- **User Authentication**: Secure authentication system for user registration and login.
- **Post Creation and Interaction**: Create, view, like, comment, and share posts within the app.
- **Messaging**: Real-time private messaging functionality between users.
- **Notifications**: Instant notifications for interactions such as likes, comments, and messages.
- **Profile Management**: Customize user profiles with details, profile pictures, and settings.
- **Search Functionality**: Search for users, posts, and content within the app.

## Installation

### Prerequisites

- **Flutter SDK**: [Install Flutter](https://flutter.dev/docs/get-started/install)
- **Dart SDK**: Included with Flutter installation
- **Git**: [Install Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

### Steps

1. **Clone the Repository**
    ```bash
    git clone https://github.com/Aj3322/CODECLAUSE/tree/main/social_media_app
    cd social_media_app
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

- **Authentication**: Register a new account or log in with existing credentials securely.
- **Post Interaction**: Create, view, like, comment, and share posts with other users.
- **Messaging**: Engage in private conversations with other users via direct messages.
- **Notifications**: Stay updated with real-time notifications for interactions and activities.
- **Profile Customization**: Personalize user profiles with biographical information and profile pictures.
- **Search**: Discover users, posts, and content using the built-in search functionality.

### Navigation

- **Home Screen**: Access the main feed for viewing and interacting with posts.
- **Messaging**: Communicate privately with other users through direct messages.
- **Notifications**: View and manage notifications for interactions and activities.
- **Profile**: Customize profile settings, view posts, followers, and following.
- **Search**: Explore users, posts, and content using the search feature.

## Project Structure

```plaintext
lib/
├── data/
│   ├── models/
│   │   ├── comment_model.dart
│   │   ├── message_model.dart
│   │   ├── notification_model.dart
│   │   ├── post_model.dart
│   │   └── user_model.dart
│   └── repositories/
│       ├── comment_repository.dart
│       ├── message_repository.dart
│       ├── notification_repository.dart
│       ├── post_repository.dart
│       ├── storage_repo.dart
│       └── user_repository.dart
├── enum/
│   └── enum.dart
├── ui/
│   ├── bindings/
│   │   ├── auth_binding.dart
│   │   ├── chat_binding.dart
│   │   ├── comments_binding.dart
│   │   ├── home_binding.dart
│   │   ├── notifications_binding.dart
│   │   ├── post_create_binding.dart
│   │   ├── profile_binding.dart
│   │   ├── search_binding.dart
│   │   └── settings_binding.dart
│   ├── pages/
│   │   ├── auth/
│   │   │   ├── login_page.dart
│   │   │   └── signup_page.dart
│   │   ├── chat/
│   │   │   ├── chat_page.dart
│   │   │   └── conversation_page.dart
│   │   ├── comments/
│   │   │   └── comments_page.dart
│   │   ├── home/
│   │   │   ├── home_page.dart
│   │   │   └── home_view.dart
│   │   ├── notifications/
│   │   │   └── notifications_page.dart
│   │   ├── post_create/
│   │   │   └── post_create_page.dart
│   │   ├── profile/
│   │   │   ├── profile_page.dart
│   │   │   └── profile_update.dart
│   │   ├── search/
│   │   │   └── search_page.dart
│   │   └── settings/
│   │       └── settings_page.dart
│   ├── theme/
│   │   └── app_theme.dart
│   └── widgets/
│       └── custom_widgets.dart
└── utils/
    └── app_routes.dart
```

## Dependencies

- `flutter`: SDK for building mobile applications
- `get`: GetX for state management and dependency injection
- `hive`: Lightweight and fast key-value database
- `hive_flutter`: Flutter integration for Hive
- `firebase_auth`: Firebase authentication for user management
- `firebase_core`: Firebase core functionality
- `cloud_firestore`: Firebase Firestore for real-time database functionality
- `firebase_storage`: Firebase Cloud Storage for storing media files
- `firebase_messaging`: Firebase Cloud Messaging for push notifications
- `image_picker`: For picking images from the gallery
- `url_launcher`: For launching URLs, emails, etc.
- `path_provider`: For accessing device paths

## Screenshots

![Home Screen](screenshots/home_screen.png) ![Profile Screen](screenshots/profile_screen.png)

## Contributions

Contributions to this project are welcome. If you find any issues or have suggestions for improvements, please open an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## Acknowledgements

- Special thanks to the mentors and colleagues for their support and guidance throughout the development process.
- Appreciation to the Flutter and GetX communities for their valuable contributions and resources.

---
