# Mobile App - iOS Template

## 📁 Cấu trúc dự án

```
Mobile App/
├── App/                          # App lifecycle & coordination
│   └── AppCoordinator.swift      # Main navigation coordinator
├── Core/                         # Core functionality
│   ├── Network/                  # API & Networking
│   │   ├── APIClient.swift
│   │   ├── APIEndpoint.swift
│   │   └── NetworkError.swift
│   ├── Storage/                  # Data persistence
│   │   └── KeychainManager.swift
│   └── Extensions/               # Swift extensions
│       └── View+Extensions.swift
├── Features/                     # Feature modules (MVVM)
│   ├── Auth/
│   │   ├── Views/               # Login, Register
│   │   ├── ViewModels/          # AuthViewModel
│   │   └── Models/              # AuthModels
│   ├── Home/
│   │   ├── Views/
│   │   ├── ViewModels/
│   │   └── Models/
│   └── Profile/
│       ├── Views/
│       ├── ViewModels/
│       └── Models/
├── Shared/                       # Shared components
│   ├── Components/
│   │   ├── Buttons/
│   │   └── Cards/
│   ├── Theme/
│   │   ├── AppColors.swift
│   │   └── AppTypography.swift
│   ├── Constants/
│   │   └── AppConstants.swift
│   └── Utils/
│       └── Validators.swift
└── Resources/
    └── Assets.xcassets
```

## 🏗️ Kiến trúc

- **Pattern**: MVVM (Model-View-ViewModel)
- **Architecture**: Clean Architecture + Feature-based
- **Navigation**: Coordinator Pattern
- **State Management**: SwiftUI @StateObject, @Published
- **Storage**: Keychain (secure), UserDefaults (preferences)
- **Networking**: async/await với URLSession

## ✨ Features đã implement

### ✅ Core
- APIClient với async/await
- Keychain Manager cho token storage
- Network error handling
- Custom View extensions

### ✅ Authentication
- Login screen
- Register screen
- Token management
- Auth state management

### ✅ Home
- Home view với item list
- Pull to refresh
- Error handling

### ✅ Profile
- User profile view
- Logout functionality

### ✅ Shared Components
- Theme system (Colors, Typography)
- Validators (Email, Password, Phone)
- Reusable buttons
- Constants management

## 🚀 Cách sử dụng

### 1. Chạy app
- Mở `Mobile App.xcodeproj` trong Xcode
- Chọn simulator hoặc device
- Nhấn `Cmd + R` để build và run

### 2. Kết nối Backend
Mở `Core/Network/APIClient.swift` và thay đổi `baseURL`:

```swift
private let baseURL = "https://your-api-domain.com"
```

### 3. Thêm Feature mới
Tạo structure trong `Features/`:

```
Features/NewFeature/
├── Views/
│   └── NewFeatureView.swift
├── ViewModels/
│   └── NewFeatureViewModel.swift
└── Models/
    └── NewFeatureModels.swift
```

### 4. Thêm API Endpoint
Thêm vào `Core/Network/APIEndpoint.swift`:

```swift
case newFeature
// ...
case .newFeature:
    return "/api/new-feature"
```

## 📱 Screens

### Login
- Email validation
- Password validation
- Error handling
- Navigation to Register

### Register
- Name, Email, Password validation
- Password confirmation
- Auto login after success

### Home
- Tab navigation
- Item list
- Pull to refresh
- Error states

### Profile
- User info display
- Logout button

## 🔐 Security

- Token storage: Keychain
- HTTPS enforced
- Input validation
- Error message sanitization

## 🎨 Theme Customization

### Colors
Edit `Shared/Theme/AppColors.swift`:
```swift
static let primary = Color("YourPrimaryColor")
```

### Typography
Edit `Shared/Theme/AppTypography.swift`:
```swift
static let title = Font.title.weight(.bold)
```

## 🧪 Testing

- Unit tests: `Mobile AppTests/`
- UI tests: `Mobile AppUITests/`

## 📝 Best Practices

1. **Separation of Concerns**: View, ViewModel, Model tách biệt
2. **Reusability**: Components tái sử dụng trong `Shared/`
3. **Type Safety**: Sử dụng enums cho constants
4. **Async/Await**: Modern concurrency cho networking
5. **Error Handling**: Comprehensive error handling
6. **Security**: Keychain cho sensitive data

## 🔄 Next Steps

### Backend (Swift Vapor)
1. Tạo Vapor project
2. Implement API endpoints
3. Connect với database
4. Deploy server

### Mobile enhancements
1. Add caching layer
2. Implement offline mode
3. Add push notifications
4. Add analytics
5. Add unit tests

## 📚 Tài liệu tham khảo

- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui)
- [Swift Concurrency](https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html)
- [Vapor Framework](https://docs.vapor.codes)

## 👨‍💻 Author

Created by Ho Van Chuong
Date: January 11, 2025

---

**Note**: Template này đã sẵn sàng để triển khai. Chỉ cần kết nối với backend API và customize theo yêu cầu dự án.
