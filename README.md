Finley Spending Dashboard App

A Flutter application that displays spending insights across various categories using a clean architecture with BLoC for state management.

Setup Instructions

Clone the repository

git clone <your-repo-url>
cd finely_app


Install Flutter dependencies

flutter pub get


iOS Setup (if running on iOS)
Make sure CocoaPods is installed:

sudo gem install cocoapods
cd ios
pod install
cd ..


Run the app

flutter run

Architecture and State Management

The app follows a clean architecture pattern:

Data Layer: Handles API calls (CategoryApi) and repository implementation (CategoryRepositoryImpl).

Domain Layer: Contains use cases like GetCategories.

Presentation Layer: Widgets and UI, including CurvedWhiteContainer, LocationInsight, and category grid.

State Management

BLoC (Business Logic Component) is used to manage state:

CategoryBloc loads categories and emits states like CategoryLoading, CategoryLoaded, and CategoryError.

The UI listens to state changes via BlocBuilder and updates accordingly.

JSON Data Usage

Category data is fetched from a JSON source (mock or API) containing fields like:

{
"finleyCategory": "TRANSPORTATION",
"finleyCategoryName": "Transportation",
"categorySpend": 11.73,
"spendStatus": "UNDER_SPENT",
"spendPercentage": 15.79,
"spendRemaining": 62.56
}


Each item is mapped to a Category model using fromJson.

The UI displays:

Category name

Circular progress indicator based on spendPercentage

Spend amount (categorySpend / spendRemaining)

Spend status text

The category grid is responsive and ensures proper alignment with fixed heights for text and icons.

Location Feature

The app fetches the user’s location to display the city name using Geolocator and PlacemarkFromCoordinates.

Handles permission states:

Requests location permission

Detects if permission is permanently denied

Shows an “Open Settings” button when necessary

Assumptions Made

JSON structure is consistent for all categories. Missing fields are treated as defaults (0.0 for numbers, empty string for text).

Category grid displays a maximum of 4 items per row with fixed child aspect ratio for alignment.

The app assumes location permission may be denied permanently and handles it gracefully via UI.

Only essential plugins (Geolocator, Permission Handler) are used; other plugins follow Flutter defaults.

Folder Structure (Example)
lib/
├── features/
│   └── spending_dashboard/
│       ├── data/
│       │   ├── datasources/
│       │   │   └── category_api.dart
│       │   └── repository/
│       │       └── category_repository_impl.dart
│       ├── domain/
│       │   └── usecases/
│       │       └── get_categories.dart
│       └── presentation/
│           ├── widgets/
│           └── screens/
└── main.dart
