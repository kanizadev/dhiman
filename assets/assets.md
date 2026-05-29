# ধীমান (Dhiman) — Image Assets Guide

## App Overview
Educational platform for SSC & HSC students in Bangladesh. Brand colors: cream, coffee brown, soft green, sky blue, peach, caramel, soft yellow.

---

## 1. App Icon (All Platforms)

| Platform | Sizes Needed |
|----------|-------------|
| Android  | 48×48, 72×72, 96×96, 144×144, 192×192 |
| iOS      | 20×20, 29×29, 40×40, 58×58, 60×60, 76×76, 80×80, 87×87, 120×120, 152×152, 167×180, 180×180, 1024×1024 |
| macOS    | 16×16, 32×32, 64×64, 128×128, 256×256, 512×512, 1024×1024 |
| Windows  | ICO format (multi-res) |
| Web/PWA  | 192×192, 512×512 (standard + maskable) |

**Prompt to generate:**

> Generate a minimal flat app icon for "Dhiman" — a Bengali educational app for SSC/HSC students in Bangladesh. The icon should feature a stylized open book with a rising sun above it, using a warm palette: cream background, coffee brown book, soft yellow sun accent. Clean, friendly, modern. Suitable as a mobile app icon — no text, no complex details. Delivered as a 1024×1024 PNG with transparent background.

---

## 2. Onboarding Illustrations (3 screens)

Currently drawn via CustomPaint (basic shapes). Replace with actual character illustrations.

### 2a. Study Desk illustration

**Prompt to generate:**

> A flat, friendly illustration of a Bangladeshi student sitting at a study desk, focused on learning. The student wears a casual shirt (green tones), has a book open on the desk, a small desk lamp glowing warm yellow nearby. Background is a soft rounded rectangle in peach color. Minimalist, cute, modern vector illustration style. Warm, motivating mood. Suitable for a mobile app onboarding screen. 600×500px, PNG.

### 2b. Goals / Targets illustration

**Prompt to generate:**

> A flat vector illustration showing three colorful circular progress/goal icons arranged horizontally — peach, sky blue, and soft green — with small checkmark or star symbols inside each. A subtle upward arrow or growth line connects them. Represents setting goals and improving yourself. Clean, minimal, motivational. Suitable for a student-focused mobile app onboarding screen. 600×500px, PNG.

### 2c. Community illustration

**Prompt to generate:**

> A flat illustration of three diverse Bangladeshi students standing together in a circle, smiling and talking. They appear friendly and supportive — representing a positive learning community. Soft peach rounded rectangle background. Minimalist vector style, warm colors. Suitable for a mobile app onboarding screen. 600×500px, PNG.

---

## 3. Logo

Currently text-based (`ধীমান` + sun icon). Optionally replace with an image logo.

**Prompt to generate:**

> A flat vector logo mark for "Dhiman" — a Bengali word meaning "intelligent/wise". An open book shape merging with a rising sun, using warm colors: coffee brown for the book, soft yellow for the sun. Clean, minimal, modern. Suitable as an app logo mark (no text). Delivered as 200×200px PNG with transparent background.

---

## 4. Splash / Launch Screen

iOS currently uses default placeholder images (168×185, 336×370, 504×555). Android uses white background only.

**Prompt to generate:**

> A clean splash screen background for "Dhiman" — a mobile educational app. Soft cream background with subtle decorative blobs in soft green and sky blue (same style as the app's theme). Minimal, light, welcoming. No text. Delivered as a 1284×2778px PNG (iPhone 14 Pro Max resolution, scalable). Alternatively, a simpler 504×555 version for iOS LaunchImage.

---

## 5. Decorative Background Elements

Currently implemented as colored Container widgets with rounded corners. Optionally replace with SVG illustrations.

**Prompt to generate:**

> Three decorative abstract blob shapes in SVG format. Soft organic rounded forms in the colors: soft green (#A8D5BA), sky blue (#B3D4E0), and peach (#F7C6A8). Used as floating background decorations in a student-friendly mobile app. Transparent background, minimal design, each blob about 200×200px.

---

## 6. Empty State / Error Illustrations (optional)

**Prompt to generate:**

> A friendly flat illustration for an empty state in a student app — a cute open book with a small question mark above it, and a few scattered sparkles. Soft cream background. Minimalist vector style. 400×300px, PNG.

---

## Installation

1. Place generated PNGs in `assets/images/`
2. Place SVGs in `assets/svg/`
3. Register in `pubspec.yaml`:
   ```yaml
   flutter:
     assets:
       - assets/images/
       - assets/svg/
   ```
4. Use `flutter pub get` to sync
