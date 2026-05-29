# ধীমান (Dhiman)

A modern cross-platform educational ecosystem for SSC and HSC students in Bangladesh — built with **Flutter** and **Firebase**.

## Features

- **Smart Learning** — Board questions (MCQ/CQ), chapters, notes, bookmarks
- **Online Exams** — Live timed exams, auto-submit, rankings
- **Analytics** — Streaks, weekly reports, subject performance
- **Productivity** — Pomodoro, goals, to-do, habits
- **Social** — Study feed, achievements, positive community
- **Auth** — Email, Bangladesh phone (+880), Google Sign-In

## Design

Playful minimalistic UI with coffee-brown palette, soft gradients, rounded cards, and Bengali-friendly typography (Noto Sans Bengali).

## Project Structure

```
lib/
├── core/           # Theme, router, constants, providers
├── models/         # Data models
├── services/       # Firebase, auth, preferences
├── widgets/        # Shared UI components
├── features/       # Feature-first modules
└── main.dart
```

## Getting Started

### Prerequisites

- Flutter SDK 3.11+
- Firebase project

### Run (Demo Mode)

Without Firebase configuration, the app runs in **demo mode** with mock data:

```bash
flutter pub get
flutter run
```

From the login screen, tap **ডেমো মোডে প্রবেশ**.

### Firebase Setup

1. Create a project at [Firebase Console](https://console.firebase.google.com)
2. Install FlutterFire CLI and configure:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

3. Enable **Authentication**: Email/Password, Phone, Google
4. Create **Firestore** and **Storage**
5. Deploy rules:

```bash
npx -y firebase-tools@latest login
npx -y firebase-tools@latest use --add YOUR_PROJECT_ID
npx -y firebase-tools@latest deploy --only firestore:rules,storage
```

### Android Phone Auth

Add SHA-1/SHA-256 fingerprints in Firebase Console → Project Settings → Your apps.

## Tech Stack

| Layer | Technology |
|-------|------------|
| UI | Flutter, Material 3 |
| State | Riverpod |
| Navigation | go_router |
| Backend | Firebase Auth, Firestore, Storage, FCM |
| Charts | fl_chart |

## Backend API (Cloud Functions)

This repo now includes a full Firebase backend scaffold in `functions/`:

- `api` HTTPS function (Express) with routes:
  - `GET /health`
  - `GET /users/me` (authenticated)
  - `PATCH /users/me` (authenticated)
  - `GET /users` (admin)
  - `PATCH /users/:uid/role` (admin)
- `createUserProfile` Auth trigger to auto-create `users/{uid}` on signup.

### Backend Setup

```bash
cd functions
npm install
npm run build
```

From project root:

```bash
npx -y firebase-tools@latest emulators:start --only functions
```

Or deploy:

```bash
npx -y firebase-tools@latest deploy --only functions
```

## License

Private — educational use.
