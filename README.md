# Watkins Step Counter App

Watkins is a step counter and walking guidance app available on both Android and iOS. It utilizes mobile device sensors to detect user movement, accurately track steps, and deliver interactive walking instructions through audio-visual feedback.

## 🌟 Features

### Core Functionality
- **Step Counting**: Real-time step detection using device sensors
- **Distance Tracking**: Automatic distance calculation based on steps taken
- **Walking Guidance**: Interactive walking instructions with animations
- **Audio Feedback**: Voice prompts and sound effects for walking directions
- **Visual Animations**: GIF animations for different walking phases
- **User Personalization**: Gender-specific animations and personalized welcome

### Walking Modes
- **Version 1**: Simple walking mode with gender-specific animations
- **Version 2**: Advanced walking mode with multiple phases:
  - Stand up and walk forward
  - Turn around and walk backward
  - Sit down at completion

### User Experience
- **Welcome Flow**: User registration with name and gender selection
- **Goal Setting**: Configurable distance targets in meters
- **Real-time Feedback**: Live step count, distance, and timer display
- **Result Summary**: Detailed session statistics and achievements
- **Haptic Feedback**: Vibration alerts for phase transitions (iOS)

## 📱 Platform Support

### Android
- **Minimum SDK**: API 21 (Android 5.0)
- **Target SDK**: API 33 (Android 13)
- **Language**: Kotlin
- **Architecture**: MVVM with Repository pattern

### iOS
- **Minimum iOS Version**: 9.0
- **Language**: Swift
- **Framework**: UIKit with Storyboards
- **Motion Detection**: CoreMotion framework

## 🏗️ Architecture

### Android Architecture
```
app/
├── src/main/java/com/example/stepcounterapp/
│   ├── data/
│   │   ├── repository/
│   │   │   ├── LinearAccelerationRepo.kt
│   │   │   ├── StepCounterRepo.kt
│   │   │   └── StepDetectorRepo.kt
│   │   └── utils/
│   │       ├── AnimationType.kt
│   │       ├── Constants.kt
│   │       └── MyPreferenceManager.kt
│   └── presentation/
│       ├── ui/
│       │   ├── EnterDetailActivity.kt
│       │   ├── MainActivity.kt
│       │   ├── ResultActivity.kt
│       │   ├── SelectMetersActivity.kt
│       │   ├── SelectVersionActivity.kt
│       │   └── WelcomeUserActivity.kt
│       └── viewmodel/
│           └── StepCounterViewModel.kt
```

### iOS Architecture
```
Pedometer/
├── Application/
│   ├── AppDelegate.swift
│   ├── SceneDelegate.swift
│   ├── UserDefaults+Extension.swift
│   └── ViewController.swift
├── Controllers/
│   ├── PedometerViewController.swift
│   ├── PedometerViewController2.swift
│   ├── PedometerViewController3.swift
│   ├── ResultViewController.swift
│   ├── StartViewController.swift
│   └── WelcomeViewController.swift
├── Extension/
│   └── ImageGif.swift
└── Assets/
    ├── Gifs/
    └── Sounds/
```

## 🚀 Getting Started

### Android Setup

#### Prerequisites
- Android Studio (latest version recommended)
- Android SDK (API level 21+)
- Gradle

#### Installation
1. Clone the repository:
   ```bash
   git clone <your-repo-url>
   ```

2. Open the project in Android Studio:
   - File > Open > Select the `Android` directory

3. Build the project:
   ```bash
   ./gradlew assembleDebug
   ```

4. Run the app on an emulator or physical device.

#### Android Dependencies
```gradle
dependencies {
    implementation 'androidx.core:core-ktx:1.7.0'
    implementation 'androidx.appcompat:appcompat:1.5.1'
    implementation 'com.google.android.material:material:1.7.0'
    implementation 'androidx.constraintlayout:constraintlayout:2.1.4'
    
    // GIF animations
    implementation "pl.droidsonroids.gif:android-gif-drawable:1.2.22"
    
    // ViewModel and LiveData
    implementation "androidx.lifecycle:lifecycle-viewmodel-ktx:2.5.1"
    implementation "androidx.lifecycle:lifecycle-runtime-ktx:2.5.1"
    implementation "androidx.lifecycle:lifecycle-livedata-ktx:2.5.1"
    implementation "androidx.activity:activity-ktx:1.6.1"
}
```

### iOS Setup

#### Prerequisites
- Xcode (latest version recommended)
- iOS 9.0+ deployment target
- CocoaPods

#### Installation
1. Navigate to the iOS directory:
   ```bash
   cd IOS
   ```

2. Install dependencies:
   ```bash
   pod install
   ```

3. Open the workspace:
   ```bash
   open Pedometer.xcworkspace
   ```

4. Build and run the project in Xcode.

#### iOS Dependencies
```ruby
target 'Pedometer' do
  use_frameworks!
  pod 'SwiftLoader'
end
```

## 📋 Permissions

### Android Permissions
The app requires the following permissions (see `AndroidManifest.xml`):
- `android.permission.ACTIVITY_RECOGNITION` - For step detection
- `android.permission.FOREGROUND_SERVICE` - For background processing
- `android.permission.WAKE_LOCK` - To keep device awake during sessions

### iOS Permissions
- Motion & Fitness access for step counting
- Microphone access for audio feedback

## 🎯 Usage Flow

1. **Welcome Screen**: Enter your name and select gender
2. **Version Selection**: Choose between Version 1 (simple) or Version 2 (advanced)
3. **Distance Setup**: Select your walking goal in meters
4. **Walking Session**: Follow the animated instructions and audio prompts
5. **Results**: View your session statistics and achievements

## 🔧 Key Components

### Android Components
- **StepCounterViewModel**: Manages step counting logic and UI state
- **StepCounterRepo**: Handles sensor data and step detection
- **AnimationType**: Enum for different walking animation states
- **MyPreferenceManager**: Manages user preferences and settings

### iOS Components
- **PedometerViewController**: Main step counting interface
- **CMPedometer**: Core Motion framework for step detection
- **AVAudioPlayer**: Audio feedback system
- **SwiftLoader**: Loading animations

## 🎨 UI/UX Features

### Visual Elements
- **GIF Animations**: Walking, sitting, and turning animations
- **Progress Indicators**: Real-time step and distance counters
- **Timer Display**: Session duration tracking
- **Gender-Specific UI**: Different animations for male/female users

### Audio Features
- **Voice Prompts**: Clear walking instructions
- **Sound Effects**: Phase transition alerts
- **Background Music**: Optional audio accompaniment

## 📊 Data Management

### User Preferences
- User name and gender storage
- Version preference (1 or 2)
- Session history and statistics

### Session Data
- Steps taken during session
- Distance traveled
- Time elapsed
- Walking phase completion status

## 🔄 Version Differences

### Version 1 (Simple Mode)
- Basic walking animation
- Gender-specific character animations
- Straightforward walking instructions

### Version 2 (Advanced Mode)
- Multi-phase walking routine
- Complex animations (stand up, walk, turn around, sit down)
- Enhanced audio-visual feedback
- Progressive difficulty levels

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Authors

- **Development Team** - Initial work
- **Contributors** - See [Contributors](CONTRIBUTORS.md)

## 🙏 Acknowledgments

- CoreMotion framework for iOS step detection
- Android Sensor API for step counting
- GIF animation libraries for visual feedback
- Audio libraries for sound effects and voice prompts

---

**Note**: This app requires physical device testing for accurate step detection and sensor functionality. Emulator testing may not provide accurate step counting results. 