# 🛒 Shopping App

A simple **Shopping Manager App** built with **Flutter**, using **Clean Architecture + BLoC**.  
It allows users to add, delete, clear, and edit purchases, while tracking the total cost and an optional spending limit.

---

## ✨ Features

- Add purchases with:
  - Name
  - Quantity
  - Unit Price
- Automatic subtotal calculation
- Edit or delete purchases
- Clear all purchases with confirmation
- Spending limit:
  - Define, update, or remove a limit
  - Display remaining budget or excess
- Persistent storage for purchases and limit
- Reactive UI with BLoC

---

## 🏛️ Architecture

This project follows **Clean Architecture** with **MVVM** principles:

```
lib/
│── core/               # Dependency injection, utils
│── data/               # Local/remote data sources, repositories implementation
│── domain/             # Entities, use cases, repository interfaces
│── features/
│   └── purchases/      # Purchases feature
│       ├── data/       
│       ├── domain/     
│       └── presentation/
│           ├── bloc/   # BLoC state management
│           └── ui/     # Screens & widgets
```

---

## 🛠️ Tech Stack

- [Flutter](https://flutter.dev/) (UI Framework)
- [BLoC](https://bloclibrary.dev/) (State Management)
- [Equatable](https://pub.dev/packages/equatable) (Value equality)
- [GetIt](https://pub.dev/packages/get_it) (Dependency Injection)
- [Hive](https://pub.dev/packages/hive) (Local Storage)

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed
- Android Studio or VS Code with Flutter/Dart extensions

### Installation
```bash
git clone https://github.com/yourusername/shopping_flutter.git
cd shopping_flutter
flutter pub get
flutter run
```

---

## 📄 License

This project is licensed under the MIT License.
