# KigaliPriceCheck Mobile App

A crowdsourced platform that enables real-time price comparison between suppliers and geographies in Rwanda, targeting pricing transparency and market efficiency.

## 📱 About

KigaliPriceCheck addresses the crucial issue of pricing transparency in Rwandan markets where consumers are forced to overpay for necessities due to severe information asymmetry. The application provides consumers with the knowledge they need to make informed purchase decisions through community-verified pricing data from informal and formal vendors.

## 🎯 Key Features

- **Real-time Price Comparison**: Compare prices across vendors and locations
- **Crowdsourced Data**: Community-driven price submissions and verification
- **Smart Shopping Lists**: Budget tracking with cost optimization
- **Vendor Discovery**: Find nearby vendors with ratings and reviews
- **Price Alerts**: Get notified when target prices are met
- **Market Analytics**: Track spending patterns and market trends
- **Multi-language Support**: Kinyarwanda, English, and French
- **Offline Capability**: Access saved data without internet connection

## 📱 App Screens (21 Complete Screens)

### Authentication & Onboarding (5 screens)
1. **Welcome Page** - "Compare prices fairly in Rwanda!" with market illustration
2. **Community-Powered Page** - "See real-time prices from locals"  
3. **Sign In Page** - Email/password login with Google & Facebook options
4. **Create Account Page** - Registration form with password strength validation
5. **Phone Verification Page** - 4-digit SMS code verification

### Main Application (8 screens)
6. **Home/Dashboard Page** - Search bar, trending prices, nearby stores, quick categories
7. **Search/Product List Page** - Product search with filters (Tomatoes, Onions, Potatoes)
8. **Price Comparison Page** - Graph/Table view with price trends and analysis
9. **Product Details Page** - Individual product page (like Cooking Oil with price history)
10. **Add Price Page** - Price submission form with photo upload
11. **Profile Page** - User profile with stats and settings (Jean-Pierre N.)
12. **Notifications Page** - Price alerts, community replies, app updates
13. **Settings Page** - User preferences and account settings

### Enhanced Features (8 screens)
14. **Vendor List Page** - Browse all markets/stores
15. **Vendor Details Page** - Individual vendor information and reviews
16. **Vendor Map Page** - Map view of nearby vendors
17. **Shopping Lists Page** - Manage shopping lists and budgets
18. **Create List Page** - Add new shopping list with items
19. **Budget Tracker Page** - Expense tracking and analytics
20. **User Submissions Page** - Price submission history (12 submissions)
21. **Saved Products Page** - Bookmarked items (23 products)

## 🏗️ Architecture

This project follows **Flutter Clean Architecture** with **BLoC** state management:

```
lib/
├── core/                   # Shared utilities and constants
│   ├── constants/         # App constants, colors, strings
│   ├── errors/           # Error handling
│   ├── network/          # Network utilities
│   ├── services/         # Firebase, location, notification services
│   ├── utils/            # Validators, formatters, router
│   └── widgets/          # Reusable UI components
├── features/              # Feature-based modules
│   ├── onboarding/       # Welcome & community-powered screens
│   ├── auth/             # Sign in, create account, phone verification
│   ├── home/             # Main dashboard
│   ├── price_submission/ # Add price functionality
│   ├── price_comparison/ # Search & compare prices
│   ├── vendor_discovery/ # Vendor profiles & ratings
│   ├── shopping_list/    # Budget tracking
│   ├── profile/          # User preferences
│   └── notifications/    # Price alerts & updates
└── main.dart
```

## 🔧 Tech Stack

- **Framework**: Flutter 3.16+
- **Language**: Dart 3.0+
- **State Management**: BLoC Pattern
- **Backend**: Firebase (Firestore, Auth, Storage)
- **Maps**: Google Maps API
- **Local Storage**: SharedPreferences
- **Architecture**: Clean Architecture

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.16.0 or higher
- Dart SDK 3.0.0 or higher
- Android Studio / VS Code
- Firebase project setup
- Google Maps API key

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/kigali-price-check-mobile.git
   cd kigali-price-check-mobile
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com)
   - Enable Authentication (Email/Password, Google Sign-In, Phone Auth)
   - Create Firestore database
   - Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Place files in respective platform folders

4. **Google Maps Setup**
   - Get API key from [Google Cloud Console](https://console.cloud.google.com)
   - Add to `android/app/src/main/AndroidManifest.xml`:
   ```xml
   <meta-data android:name="com.google.android.geo.API_KEY"
              android:value="YOUR_API_KEY"/>
   ```

5. **Environment Configuration**
   - Copy `.env.example` to `.env`
   - Add your API keys and configuration

6. **Run the app**
   ```bash
   flutter run
   ```

## 📊 Database Schema

### Core Collections

- **users**: User profiles and preferences
- **vendors**: Vendor information and ratings  
- **products**: Product catalog with categories
- **prices**: Price submissions with verification
- **shopping_lists**: User shopping lists and budgets
- **reviews**: Vendor reviews and ratings
- **notifications**: Price alerts and updates
- **price_alerts**: User-defined price monitoring
- **user_favorites**: Bookmarked vendors and products
- **market_analytics**: Aggregated market data

See [ERD Documentation](docs/database_schema.md) for detailed schema.

## 🔐 Firebase Security Rules

The app implements comprehensive security rules:

```javascript
// Users can only access their own data
match /users/{userId} {
  allow read, write: if request.auth.uid == userId;
}

// Prices are readable by all authenticated users
match /prices/{priceId} {
  allow read: if request.auth != null;
  allow create: if request.auth.uid == resource.data.userId;
}

// Vendors are readable by all, writable by verified users
match /vendors/{vendorId} {
  allow read: if request.auth != null;
  allow write: if request.auth != null && 
    get(/databases/$(database)/documents/users/$(request.auth.uid)).data.reputationScore > 50;
}
```

## 🧪 Testing

### Running Tests

```bash
# Unit tests
flutter test

# Widget tests
flutter test test/widget_test.dart

# Integration tests
flutter test integration_test/
```

### Test Coverage

- Unit Tests: Business logic and utilities
- Widget Tests: UI components and interactions  
- Integration Tests: End-to-end user flows (auth, price submission, shopping list)

Target coverage: **≥70%**

## 📱 Screenshots

| Home Screen | Price Comparison | Vendor Discovery |
|-------------|------------------|------------------|
| ![Home](screenshots/home.png) | ![Prices](screenshots/prices.png) | ![Vendors](screenshots/vendors.png) |

| Shopping List | Profile | Price Submission |
|---------------|---------|------------------|
| ![Shopping](screenshots/shopping.png) | ![Profile](screenshots/profile.png) | ![Submit](screenshots/submit.png) |

## 🎨 Design System

- **Primary Color**: #1E88E5 (Blue)
- **Secondary Color**: #FF7043 (Orange)  
- **Success Color**: #4CAF50 (Green)
- **Typography**: Material Design 3
- **Icons**: Material Icons + Custom icons

## 🌍 Localization

Supported languages:
- 🇬🇧 English (default)
- 🇷🇼 Kinyarwanda
- 🇫🇷 French

## 📈 Performance

- **App Size**: <50MB
- **Launch Time**: <3 seconds
- **Offline Support**: Core features available
- **Memory Usage**: Optimized for low-end devices

## 🤝 Contributing

### Team Members

| Name | Role | Contribution |
|------|------|-------------|
| Alice Mukarwema | Lead Developer | Authentication, Core Architecture |
| Elisa Twizeyimana | Frontend Developer | UI/UX Implementation |
| Erneste Ntezirizaza | Backend Developer | Firebase Integration, APIs |
| Caline Uwingabire | QA Engineer | Testing, Documentation |
| Noella Umwali | Product Manager | Requirements Analysis, User Research |

### Development Workflow

1. Create feature branch: `git checkout -b feature/feature-name`
2. Make changes and commit: `git commit -m "feat: add feature"`
3. Push to branch: `git push origin feature/feature-name`
4. Create Pull Request
5. Code review and merge

### Commit Convention

```
feat: add new feature
fix: bug fix
docs: documentation update
style: formatting changes
refactor: code refactoring
test: add tests
chore: maintenance tasks
```

## 📋 Project Status

- [x] Project Setup & Architecture
- [x] Clean Architecture Structure (62+ files created)
- [x] Authentication System Design
- [x] Database Design & ERD
- [ ] UI Implementation (21 screens)
- [ ] Price Submission Module
- [ ] Price Comparison Features
- [ ] Vendor Discovery
- [ ] Shopping List Management
- [ ] Firebase Integration
- [ ] Testing Implementation
- [ ] Documentation Completion

## 🚧 Known Limitations

- Maps require internet connection
- Price verification depends on community participation
- Limited to Kigali area initially
- Requires GPS for location-based features

## 🔮 Future Enhancements

- [ ] Expand to other Rwandan cities
- [ ] Barcode scanning for products
- [ ] Voice search functionality
- [ ] Predictive price analytics
- [ ] Vendor dashboard web app
- [ ] Integration with mobile money payments

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support

For support and questions:
- **Email**: support@kigalipricecheck.rw
- **GitHub Issues**: [Create an issue](https://github.com/yourusername/kigali-price-check-mobile/issues)
- **Documentation**: [Wiki](https://github.com/yourusername/kigali-price-check-mobile/wiki)

## 🙏 Acknowledgments

- Rwanda Development Board for market research support
- Local vendors for participating in user testing
- Flutter and Firebase communities
- Course instructors and peers
- Grace Uwimana and other target users for valuable feedback

---

**Built with ❤️ for Rwanda's digital transformation**

> "Every franc saved on groceries helps my children's education fund grow." - Grace Uwimana, Target User

## 📋 Quick Setup Commands

If you're setting up the project from scratch:

```bash
# Create Flutter project
flutter create kigali_price_check_mobile
cd kigali_price_check_mobile

# Create Clean Architecture structure
mkdir -p lib/{core/{constants,errors,network,services,utils,widgets},features/{onboarding/presentation/{bloc,pages,widgets},auth/{data/{datasources,models,repositories},domain/{entities,repositories,usecases},presentation/{bloc,pages,widgets}},home,price_submission,price_comparison,vendor_discovery,shopping_list,profile,notifications},l10n}

# Create all core files
touch lib/core/constants/{app_constants.dart,app_colors.dart,app_strings.dart,api_constants.dart,storage_keys.dart}
# ... (additional touch commands for all files)

# Install dependencies
flutter pub get

# Run the app
flutter run
```