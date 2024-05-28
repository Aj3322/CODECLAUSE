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
- **Comment**: Add and view comments on posts to engage with content and other users.
- **Like**: Express appreciation for posts by liking them, and see who liked your posts.
- **Following/Unfollowing**: Follow other users to see their posts in your feed, and unfollow to stop seeing their updates.

### Navigation

- **Home Screen**: Access the main feed for viewing and interacting with posts. (`Routes.HOME`)
- **Home View**: Alternative view for the home feed. (`Routes.HOMEVIEW`)
- **Search**: Explore users, posts, and content using the search feature. (`Routes.SEARCH`)
- **Create Post**: Share new content by creating and posting updates to the feed. (`Routes.POST_CREATE`)
- **Settings**: Customize application settings. (`Routes.SETTINGS`)
- **Profile**: Customize profile settings, view posts, followers, and following. (`Routes.PROFILE`)
- **Profile Update**: Update and personalize profile information. (`Routes.PROFILEUPDATE`)
- **Messaging**: Communicate privately with other users through direct messages. (`Routes.CHAT`)
- **Chat Screen**: View specific chat conversations. (`Routes.CHATSCREEN`)
- **Comments**: Add and view comments on posts to engage with content and other users. (`Routes.COMMENTS`)
- **Story**: View and create stories. (`Routes.STORY`)
- **Notifications**: View and manage real-time notifications for interactions and activities. (`Routes.NOTIFICATIONS`)
- **Login**: Log in with existing credentials. (`Routes.LOGIN`)
- **Signup**: Register a new account. (`Routes.SIGNUP`)
- **Like**: Express appreciation for posts by liking them, and see who liked your posts.

## Routes

```plaintext
  HOME = '/home';
  HOMEVIEW = '/homeview';
  SEARCH = '/search';
  POST_CREATE = '/post-create';
  SETTINGS = '/settings';
  PROFILE = '/profile';
  PROFILEUPDATE = '/profile-update';
  SEARCHUSERPROFILE = '/other-profile';
  CHAT = '/chat';
  CHATSCREEN = '/chat-screen';
  COMMENTS = '/comments';
  STORY = '/story';
  NOTIFICATIONS = '/notifications';
  LOGIN = '/login';
  SIGNUP = '/signup';
```  

## Project Structure

```plaintext
lib
├── app
│   ├── bindings
│   │   ├── auth_binding.dart
│   │   ├── chat_binding.dart
│   │   ├── comments_binding.dart
│   │   ├── home_binding.dart
│   │   ├── notifications_binding.dart
│   │   ├── post_create_binding.dart
│   │   ├── profile_binding.dart
│   │   ├── search_binding.dart
│   │   ├── settings_binding.dart
│   │   └── story_binding.dart
│   ├── controllers
│   │   ├── auth_controller.dart
│   │   ├── chat_controller.dart
│   │   ├── comments_controller.dart
│   │   ├── home_controller.dart
│   │   ├── notifications_controller.dart
│   │   ├── post_create_controller.dart
│   │   ├── profile_controller.dart
│   │   ├── profile_update_controller.dart
│   │   ├── search_controller.dart
│   │   ├── settings_controller.dart
│   │   └── story_controller.dart
│   ├── data
│   │   ├── enum
│   │   │   └── enum.dart
│   │   ├── models
│   │   │   ├── comment_model.dart
│   │   │   ├── message_model.dart
│   │   │   ├── message_model.g.dart
│   │   │   ├── notfication_model.dart
│   │   │   ├── notfication_model.g.dart
│   │   │   ├── post_model.dart
│   │   │   ├── post_model.g.dart
│   │   │   ├── user_model.dart
│   │   │   └── user_model.g.dart
│   │   ├── providers
│   │   │   ├── chat_provider.dart
│   │   │   ├── local_provider.dart
│   │   │   └── remote_provider.dart
│   │   └── repositories
│   │       ├── comment_repository.dart
│   │       ├── message_repository.dart
│   │       ├── notification_repository.dart
│   │       ├── post_repository.dart
│   │       ├── storage_repo.dart
│   │       └── user_repository.dart
│   ├── routes
│   │   ├── app_pages.dart
│   │   └── app_routes.dart
│   ├── services
│   │   ├── database_service.dart
│   │   └── notification_service.dart
│   ├── ui
│   │   ├── pages
│   │   │   ├── auth
│   │   │   │   ├── login_page.dart
│   │   │   │   └── signup_page.dart
│   │   │   ├── chat
│   │   │   │   ├── chat_page.dart
│   │   │   │   └── conversation_page.dart
│   │   │   ├── comments
│   │   │   │   └── comments_page.dart
│   │   │   ├── home
│   │   │   │   ├── home_page.dart
│   │   │   │   └── home_view.dart
│   │   │   ├── notifications
│   │   │   │   └── notifications_page.dart
│   │   │   ├── post_create
│   │   │   │   └── post_create_page.dart
│   │   │   ├── profile
│   │   │   │   ├── profile_page.dart
│   │   │   │   ├── profile_update.dart
│   │   │   │   └── search_profile.dart
│   │   │   ├── search
│   │   │   │   └── search_page.dart
│   │   │   ├── settings
│   │   │   │   └── settings_page.dart
│   │   │   └── story
│   │   │       └── story_page.dart
│   │   ├── theme
│   │   │   ├── app_theme.dart
│   │   │   └── color_palette.dart
│   │   └── widgets
│   │       ├── auth_form.dart
│   │       ├── comment_widget.dart
│   │       ├── following_button.dart
│   │       ├── like_animation.dart
│   │       ├── massage_card.dart
│   │       ├── message_widget.dart
│   │       ├── post_widget.dart
│   │       ├── profile_post.dart
│   │       ├── story_widget.dart
│   │       ├── test.dart
│   │       └── trime.dart
│   └── utils
│       ├── date_time_formate.dart
│       ├── debounce.dart
│       ├── local_database_helper.dart
│       ├── media_query.dart
│       ├── remote_database_helper.dart
│       └── validators.dart
├── config
│   ├── app_config.dart
│   └── firebase_options.dart
└── main.dart
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

## UI Screenshots in Light and Dark Modes

#### Auth Screen
<img src="https://github.com/Aj3322/CODECLAUSE/assets/114848454/dd06bd77-459d-405c-a574-52d494ae45a9" height=400>
<img src="https://github.com/Aj3322/CODECLAUSE/assets/114848454/4553efdd-bbe8-4c81-a7cb-e231a38f5ef7" height=400>

#### Home Screen
<img src="https://github.com/Aj3322/CODECLAUSE/assets/114848454/f7d829db-076c-4d94-8e40-47ba6e6440f0" height=400>
<img src="https://github.com/Aj3322/CODECLAUSE/assets/114848454/234ef385-3256-4285-86be-63d3a1b64108" height=400>

#### Messaging
<img src="https://github.com/Aj3322/CODECLAUSE/assets/114848454/d3f20906-aa24-4f8c-927c-424e34579f41" height=400>
<img src="https://github.com/Aj3322/CODECLAUSE/assets/114848454/16cfec3a-6ce1-44eb-8ff5-3aff1346f84c" height=400>
<img src="https://github.com/Aj3322/CODECLAUSE/assets/114848454/23f8bcf9-99e3-41e0-9b6e-143913fd4621" height=400>
<img src="https://github.com/Aj3322/CODECLAUSE/assets/114848454/8b22428b-69ff-4437-9e68-503efd40160f" height=400>
<img src="https://github.com/Aj3322/CODECLAUSE/assets/114848454/459507e8-38d3-437f-a023-ec330ce35e6e" height=400>
<img src="https://github.com/Aj3322/CODECLAUSE/assets/114848454/347b4c1c-2555-4aca-9f12-e1fe78239666" height=400>

#### Notifications
<img src="https://github.com/Aj3322/CODECLAUSE/assets/114848454/bf7b5bbb-d5c6-4234-b335-7e0c7f4a6b4c" height=400>
<img src="https://github.com/Aj3322/CODECLAUSE/assets/114848454/41a71c71-c3c0-452b-a620-291955a63e6f" height=400>

#### Profile
<img src="https://github.com/Aj3322/CODECLAUSE/assets/114848454/e8ea202c-4cec-4bf0-bd25-6a4e8493b8e7" height=400>
<img src="https://github.com/Aj3322/CODECLAUSE/assets/114848454/23757aff-a582-41e0-a7a7-249e9a6c81de" height=400>
<img src="https://github.com/Aj3322/CODECLAUSE/assets/114848454/374bb350-1c84-4717-82c6-3f27b646b57c" height=400>

#### Search
<img src="https://github.com/Aj3322/CODECLAUSE/assets/114848454/cdd3211e-da6b-4471-ab56-d97c08771705" height=400>
<img src="https://github.com/Aj3322/CODECLAUSE/assets/114848454/8c628dfa-3c58-46e6-8850-b9e1a7859147" height=400>

#### Comment
<img src="https://github.com/Aj3322/CODECLAUSE/assets/114848454/955a84a7-8f1d-4377-985f-1c75ac172e4e" height=400>
<img src="https://github.com/Aj3322/CODECLAUSE/assets/114848454/eb48a464-9b92-4a54-abc2-e294f94a6a62" height=400>

#### Create Post
<img src="https://github.com/Aj3322/CODECLAUSE/assets/114848454/f859eb7f-1a6c-4820-908b-552267f68710" height=400>
<img src="https://github.com/Aj3322/CODECLAUSE/assets/114848454/16b9661f-d7f1-4f52-8092-ad7272e4566d" height=400>

## Contributions

Contributions to this project are welcome. If you find any issues or have suggestions for improvements, please open an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## Acknowledgements

- Special thanks to the mentors and colleagues for their support and guidance throughout the development process.
- Appreciation to the Flutter and GetX communities for their valuable contributions and resources.

---
