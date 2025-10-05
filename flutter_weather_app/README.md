# Flutter Weather App

A beautiful, modern weather application built with Flutter following the MVVM (Model-View-ViewModel) architecture pattern with Riverpod for state management.

## 📱 Features

- **Current Weather**: Get real-time weather information for your location
- **Multiple Locations**: Add and manage weather data for multiple cities
- **Location Search**: Search for cities using Google Places API
- **Automatic Location**: Auto-detect user's current location
- **Weather Details**: View temperature, humidity, wind speed, and weather conditions
- **Offline Storage**: Save weather data locally using SQLite
- **Refresh Weather**: Update all saved locations' weather data
- **Dark Theme**: Beautiful dark theme with modern UI design

## 📸 Screenshots

<div align="center">
  <img src="screenshots/Simulator Screenshot - iPhone 16 Pro - 2025-10-05 at 15.53.15.png" width="200" alt="Home Screen"/>
  <img src="screenshots/Simulator Screenshot - iPhone 16 Pro - 2025-10-05 at 15.53.25.png" width="200" alt="Weather Details"/>
  <img src="screenshots/Simulator Screenshot - iPhone 16 Pro - 2025-10-05 at 15.53.52.png" width="200" alt="Add Location"/>
  <img src="screenshots/Simulator Screenshot - iPhone 16 Pro - 2025-10-05 at 15.54.00.png" width="200" alt="Location Search"/>
  <img src="screenshots/Simulator Screenshot - iPhone 16 Pro - 2025-10-05 at 15.55.59.png" width="200" alt="Multiple Locations"/>
</div>

## 🏗️ Architecture

This project implements the **MVVM (Model-View-ViewModel)** pattern with clean architecture principles:

### 📁 Project Structure

```
lib/
├── core/                     # Core configurations
│   ├── colors.dart          # App color scheme
│   ├── ktheme.dart          # App theme configuration
│   └── providers.dart       # Riverpod providers setup
├── data/                    # Data layer
│   ├── models/             # Data models
│   │   ├── app_database.dart # SQLite database setup
│   │   └── weather_data.dart # Weather data model
│   ├── repository/         # Repository implementations
│   │   └── weather_repository.dart # Weather repo implementation
│   └── services/           # External data services
│       └── weather_service.dart # Weather API service
├── domain/                 # Domain layer
│   └── repository/         # Repository abstractions
│       └── weather_repository.dart # Weather repo interface
├── pages/                  # Presentation layer
│   ├── modelview/          # ViewModels (Notifiers)
│   │   ├── add_weather_notifier.dart # Add weather ViewModel
│   │   └── weather_notifier.dart # Main weather ViewModel
│   ├── screens/            # UI Screens (Views)
│   │   ├── add_location.dart # Add location screen
│   │   └── home_screen.dart # Main weather screen
│   └── widgets/            # Reusable UI components
└── main.dart              # App entry point
```

### 🔄 MVVM Implementation

#### **Model Layer** (`data/` & `domain/`)

- **Data Models**: `WeatherData` - Represents weather information
- **Repository Pattern**: Abstract repository interface in domain layer, concrete implementation in data layer
- **Services**: `WeatherService` - Handles API calls to Weatherbit API
- **Database**: SQLite integration for offline storage

#### **View Layer** (`pages/screens/`)

- **Home Screen**: Displays current weather and navigation
- **Add Location Screen**: Search and add new weather locations
- **Reactive UI**: Uses `ConsumerWidget` to watch state changes

#### **ViewModel Layer** (`pages/modelview/`)

- **WeatherNotifier**: Manages main weather state and user location
- **AddWeatherNotifier**: Handles adding/removing weather locations
- **State Management**: Uses Riverpod's `StateNotifier` for reactive state management

### 🔧 State Management

The app uses **Riverpod** for state management with the following providers:

```dart
// Main weather state provider
final weatherProvider = StateNotifierProvider<WeatherNotifier, WeatherState>

// Add weather functionality provider
final addWeatherProvider = StateNotifierProvider<AddWeatherNotifier, AddWeatherState>
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code
- Weather API key from [Weatherbit.io](https://www.weatherbit.io/)

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/Wandilekubheka/weather-app-flutter.git
   cd flutter_weather_app
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Setup environment variables**

   Create a `.env` file in the root directory:

   ```env
   WEATHER_API=your_weatherbit_api_key_here
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 📦 Dependencies

### Core Dependencies

- **flutter_riverpod**: State management solution
- **google_fonts**: Custom font integration
- **flutter_dotenv**: Environment variable management

### Data & Networking

- **http**: HTTP client for API calls
- **sqflite**: SQLite database for local storage
- **path**: File path manipulation

### Location & UI

- **location**: GPS location services
- **google_places_flutter**: Google Places API integration
- **cupertino_icons**: iOS-style icons

## 🌐 API Integration

The app integrates with the **Weatherbit API** to fetch weather data:

- **Current Weather**: Real-time weather conditions
- **Location-based**: Weather data by coordinates
- **City Search**: Weather data by city name

## 💾 Local Storage

Uses **SQLite** for offline data persistence:

- Weather data caching
- Multiple location storage
- Offline access to previously fetched data

## 🎨 UI/UX

- **Dark Theme**: Modern dark color scheme
- **Material Design**: Follows Material Design guidelines
- **Responsive**: Adapts to different screen sizes
- **Loading States**: Smooth loading indicators
- **Error Handling**: User-friendly error messages

## 🔧 Configuration

### Environment Setup

1. Get API key from [Weatherbit.io](https://www.weatherbit.io/api)
2. Add to `.env` file:
   ```env
   WEATHER_API=your_api_key_here
   ```

### Permissions

The app requires the following permissions:

- **Location**: To get user's current location
- **Internet**: To fetch weather data

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Wandile Kubheka**

- GitHub: [@Wandilekubheka](https://github.com/Wandilekubheka)

## 🙏 Acknowledgments

- [Weatherbit.io](https://www.weatherbit.io/) for the weather API
- [Google Places API](https://developers.google.com/places/web-service/overview) for location search
- Flutter and Dart communities for excellent documentation and support
