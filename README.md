# TaskTrial Mobile App

TaskTrial is a cross-platform mobile application built using [Flutter](https://flutter.dev). It provides an intuitive interface for managing and organizing tasks efficiently.

## 🚀 Features

- 🗂️ Project and team management  
- ✅ Task creation, assignment, and tracking  
- 👥 Member assignment and role management  
- 🔄 Real-time updates and synchronization  
- 📅 Task scheduling with time and date  
- 📊 Dashboard for project progress overview  

## 🧰 Tech Stack

- **Flutter** – Cross-platform UI toolkit  
- **Dart** – Programming language  
- **GetX** – State management and routing  
- **Firebase** – Authentication & database *(optional)*  
- **Dio** – HTTP client for API requests  
- **Lottie** – Animation support  
- **Custom Backend API** – For project/task/team management

## 🛠️ Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Android Studio or VS Code
- An emulator or a physical device

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/TaskTrial/mobile.git
   cd mobile
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

> **Note:** Make sure a simulator or a connected device is running.

## 📁 Project Structure

```
mobile-main/
├── android/           # Android native code
├── ios/               # iOS native code (if available)
├── lib/
│   ├── app.dart
│   ├── main.dart
│   ├── controllers/                    # Business logic for each feature
│   │   ├── auth/                       # Authentication-related controllers
│   │   ├── profile/                    # Profile and organization 
│   │   ├── project/                    # Project-specific controllers
│   │   ├── task/                       # Task-specific controllers
│   │   └── ...                         # Dashboard, department, team, etc.
│   ├── models/                         # Data models
│   ├── services/                       # API and data services
│   ├── utils/                          # Utilities (constants, routes)
│   ├── views/                          # UI screens
│   │   ├── auth/                       # Auth-related UI
│   │   ├── chat/                       # Chat screen
│   │   ├── dashboard/                 # Dashboard screen
│   │   ├── department/                # Department-related UI
│   │   ├── more/                      # Misc. UI
│   │   ├── organization/              # Organization UI
│   │   ├── profile/                   # Profile editing/viewing
│   │   ├── project/                   # Projects and tasks
│   │   └── team/                      # Team management screens
│   ├── widgets/                       # Flutter Dart source files
├── pubspec.yaml       # Project metadata and dependencies
```



---

Engineered with Flutter by [Youssef Else7y](https://github.com/YoussefElse7y).

[![Ask DeepWiki](https://deepwiki.com/badge.svg)](https://deepwiki.com/TaskTrial/mobile)
