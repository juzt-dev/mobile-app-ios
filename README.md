Dưới đây là phiên bản README.md đã loại bỏ toàn bộ icon/emoji, tối ưu để preview đẹp và chuyên nghiệp trên GitHub:

# Mobile App - iOS Template

A clean, scalable SwiftUI mobile app architecture using MVVM, ready for production with backend integration.

---

## Project Structure

Mobile App/
├── App/                          # App lifecycle & coordination
│   └── AppCoordinator.swift      # Main navigation coordinator
├── Core/
│   ├── Network/                  # API & Networking
│   ├── Storage/                  # Data persistence
│   └── Extensions/               # Swift extensions
├── Features/                     # Feature modules (MVVM)
│   ├── Auth/
│   ├── Home/
│   └── Profile/
├── Shared/                       # Shared components
│   ├── Components/
│   ├── Theme/
│   ├── Constants/
│   └── Utils/
└── Resources/
└── Assets.xcassets

---

## Architecture

- Pattern: MVVM (Model-View-ViewModel)
- Structure: Clean Architecture + Feature-based
- Navigation: Coordinator Pattern
- State Management: `@StateObject`, `@Published`
- Storage: Keychain + UserDefaults
- Networking: URLSession with async/await

---

## Features

### Core
- APIClient with async/await
- Keychain token storage
- Network error handler
- Custom View extensions

### Authentication
- Login & Register
- Token management
- Authentication state

### Home
- Item list
- Pull to refresh
- Error handling

### Profile
- User info
- Logout

### Shared
- Theme system (colors, fonts)
- Input validators
- Reusable components
- Constants

---

## Getting Started

### 1. Run the App
```bash
Open "Mobile App.xcodeproj" in Xcode
Select a simulator or device
Cmd + R to build and run

2. Connect to Backend

Edit Core/Network/APIClient.swift:

private let baseURL = "https://your-api-domain.com"

3. Add New Feature

Create a folder inside Features/:

Features/NewFeature/
├── Views/
├── ViewModels/
└── Models/

4. Add New API Endpoint

In APIEndpoint.swift:

case newFeature
// ...
case .newFeature:
    return "/api/new-feature"


⸻

Security
	•	Secure token storage (Keychain)
	•	HTTPS enforced
	•	Input validation
	•	Sanitized error messages

⸻

Theme Customization

Colors

In AppColors.swift:

static let primary = Color("YourPrimaryColor")

Typography

In AppTypography.swift:

static let title = Font.title.weight(.bold)


⸻

Testing
	•	Unit tests in Mobile AppTests/
	•	UI tests in Mobile AppUITests/

⸻

Best Practices
	•	Separation of concerns (MVVM)
	•	Reusable shared components
	•	Type-safe constants and APIs
	•	Modern async/await networking
	•	Clean error handling
	•	Secure sensitive data

⸻

Next Steps

Backend Integration
	•	Setup backend project (Node.js, Vapor, etc.)
	•	Implement REST APIs
	•	Connect to PostgreSQL
	•	Deploy and secure

Mobile Improvements
	•	Caching layer
	•	Offline mode
	•	Push notifications
	•	Analytics tracking
	•	Test automation

⸻

References
	•	SwiftUI Documentation￼
	•	Swift Concurrency Guide￼
	•	Vapor Framework￼

⸻

Author: Ho Van Chuong
Date: January 11, 2025

⸻

This template is production-ready and modular. Plug in your backend API and customize as needed.
