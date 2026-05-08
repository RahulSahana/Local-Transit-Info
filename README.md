# Transit Info Desk — Flutter Mobile App

A Flutter mobile app rewrite of the Transit Info Desk website for Howrah–Tarakeswar/Goghat local train schedules.

## Features

- ✅ **UP & DN Train Schedules** — All 41 UP and 40 DN trains
- ✅ **Live Train Status** — Auto-calculates Running / Reached / Scheduled based on current time
- ✅ **Next Train Widget** — Shows the next upcoming train with countdown
- ✅ **Search** — Filter trains by number or name
- ✅ **Special Notices** — Cancellations, Short Terminate, Short Origin grouped by date
- ✅ **Train Detail Sheet** — Tap any train for full details (duration, times, status)
- ✅ **Dark / Light Theme** — Persisted across app restarts
- ✅ **Live Clock** — Real-time clock in header

## Project Structure

```
lib/
├── main.dart                    # App entry point, theme state
├── theme.dart                   # Light/dark theme + color helpers
├── models/
│   └── train.dart               # Train & SpecialNotice models
├── data/
│   └── train_data.dart          # All train schedule data
├── screens/
│   ├── home_screen.dart         # Main screen with tabs + header
│   ├── train_schedule_screen.dart  # UP/DN train list
│   └── special_notices_screen.dart # Notices grouped by date
└── widgets/
    ├── next_train_widget.dart   # "Next train" banner
    ├── train_card.dart          # Individual train row
    ├── train_details_sheet.dart # Bottom sheet with train info
    └── status_badge.dart        # Status & direction badge widgets
```

## Setup & Run

### Prerequisites
- Flutter SDK ≥ 3.0.0 — [Install Flutter](https://docs.flutter.dev/get-started/install)
- Android Studio or VS Code with Flutter extension

### Steps

```bash
# 1. Navigate to project folder
cd transit_info_desk

# 2. Install dependencies
flutter pub get

# 3. Run on device/emulator
flutter run

# 4. Build release APK
flutter build apk --release
# APK will be at: build/app/outputs/flutter-apk/app-release.apk
```

### Run on specific platform
```bash
flutter run -d android   # Android
flutter run -d ios       # iOS (macOS only)
```

## Customization

### Adding new trains
Edit `lib/data/train_data.dart` — add to `upTrains` or `dnTrains`:
```dart
Train(
  trainNo: '12345',
  trainName: 'Howrah - NewStation Local',
  direction: 'UP',
  depTime: '14:30',   // 24h format
  arrTime: '16:00',
  status: TrainStatus.scheduled,
),
```

### Adding special notices
Add to the `specialNotices` list in `train_data.dart`:
```dart
SpecialNotice(
  date: '11 May 2026',
  train: Train(...),
  noticeType: TrainStatus.cancelled,
  detail: 'Optional detail text',
),
```

## Dependencies
| Package | Purpose |
|---|---|
| `google_fonts` | Oswald + JetBrains Mono + Source Code Pro fonts |
| `intl` | Date/time formatting |
| `shared_preferences` | Persist dark mode preference |
| `flutter_animate` | Smooth animations (optional use) |
