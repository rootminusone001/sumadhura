# Sumadhura Visitor Management App

A Flutter-based visitor management application designed to register visitors, manage visitor details, generate QR-code passes, and track visitor check-in and check-out activities.

## Features

- **Dashboard**
  - View total visitors registered today.
  - Track visitors currently checked in.
  - View visitors checked out today.
  - Access quick actions for registration, visitor management, and QR scanning.

- **Visitor Registration and Management**
  - Register new visitors with their personal and visit details.
  - Edit existing visitor information.
  - View visitor details.
  - Search and manage the visitor list.
  - Delete visitor records.

- **QR Code Generation**
  - Generate a unique QR code for each visitor using their visitor ID.
  - Display the QR code with visitor details.

- **QR Code Scanning**
  - Scan visitor passes using the device camera.
  - Extract the visitor ID from the scanned QR code.
  - Use the visitor ID to identify the corresponding visitor.

- **Check-in and Check-out**
  - Track visitor status through Registered, Checked In, and Checked Out.
  - Maintain check-in and check-out timestamps.
  - Restrict invalid status transitions.

- **Navigation**
  - Bottom navigation for Dashboard, Visitors, and Scan QR.
  - Separate registration and editing screens.

## Technology Stack

- **Framework:** Flutter
- **Language:** Dart
- **State Management:** BLoC (`flutter_bloc`)
- **QR Code Generation:** `qr_flutter`
- **QR Code Scanning:** `mobile_scanner`
- **Platform Support:** Android and iOS

## Project Structure

```text
lib/
├── features/
│   ├── dashboard_screen/
│   ├── homepage/
│   ├── qr_code_scanner/
│   ├── register_visitor/
│   │   ├── register_visitor_bloc/
│   │   └── screen/
│   └── visitor/
│       └── visitor_bloc/
├── model/
├── constants/
└── main.dart

assets/
├── icons/
└── images/
```

*The structure above is a representative overview; update it to match the final project directory.*

## Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK
- Android Studio or Xcode for device builds
- A configured Android emulator, iOS simulator, or physical device

### Installation

1. Clone or download the project.
2. Open a terminal in the project directory.
3. Install the dependencies:

   ```bash
   flutter pub get
   ```

4. Run the application:

   ```bash
   flutter run
   ```

## QR Code Format

The QR code contains the visitor's unique ID.

Example:

```json
{
  "id": 1
}
```

The scanner reads this value so the application can identify the visitor and retrieve their details.

## Visitor Status Workflow

```text
Registered
    ↓
Checked In
    ↓
Checked Out
```

Visitors must follow this sequence. A visitor cannot check out before checking in or check in again after checking out.

## App Branding

The application uses Sumadhura branding, including a launcher icon and a native splash screen.

## License

Specify the project's license here if it is intended for public distribution.
