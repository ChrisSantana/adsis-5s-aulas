# MVVM Example

MVVM Example is a Flutter project demonstrating the MVVM architecture with Bloc for state management. The app features user authentication, profile management, order tracking, and integration with RESTful APIs. It is structured to maintain a clean and scalable architecture.

![image](https://github.com/user-attachments/assets/20824875-060a-4626-ae09-9db98375cdf7)


## Features
- **User Authentication**
- **User Profile Management**
- **Order Management** (Complex data such as orders, items, and purchase details)
- **Google Maps Integration**
- **Interconnected Screens** (State updates across multiple views)
- **Unit Testing with TDD Approach**

## Project Architecture
This project follows the MVVM (Model-View-ViewModel) pattern with a modular folder structure:

```
configs/
  assets/
  schema_database/
  enviroment/
  injector_container/
core/
data/
  datasources/
  repositories/
domain/
  entities/
routing/
ui/
  feature_name/
    pages/
    view_models/
    widgets/
utils/
```

### MVVM Structure
- **Data Layer:** Handles API calls, local storage, and repositories.
- **Domain Layer:** Contains business logic and entities.
- **UI Layer:** Displays data and interacts with ViewModels.

## Libraries & Tools

### State Management
- **Bloc** - Handles business logic and state management.

### HTTP & Networking
- **Dio** - A powerful HTTP client for handling API requests.
- **Flutter Dotenv** - Manages environment variables.

### Dependency Injection
- **GetIt** - A service locator for dependency injection.

### Storage & Database
- **Shared Preferences** - Key-value storage for lightweight persistence.
- **Sqflite** - SQLite plugin for Flutter.

### UI Components
- **Font Awesome Flutter** - A library for scalable vector icons.
- **Intl** - Provides internationalization support.

### Testing & Code Quality
- **Flutter Lints** - Ensures best practices and clean code.
- **Mockito** - Enables unit testing by mocking dependencies.

## TODO

## Getting Started
1. Clone the repository.
2. Run `flutter pub get` to install dependencies.
3. Configure environment variables using `.env` file.
4. Run the app using `flutter run`.

