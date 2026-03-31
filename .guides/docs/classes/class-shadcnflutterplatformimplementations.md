---
title: "Class: ShadcnFlutterPlatformImplementations"
description: "Web platform-specific implementations for shadcn_flutter.   This class provides web-specific functionality, including integration  with the JavaScript preloader and theme synchronization."
---

```dart
/// Web platform-specific implementations for shadcn_flutter.
///
/// This class provides web-specific functionality, including integration
/// with the JavaScript preloader and theme synchronization.
class ShadcnFlutterPlatformImplementations {
  /// Called when the app is initialized.
  ///
  /// Notifies the JavaScript preloader that the Flutter app is ready
  /// by dispatching a "shadcn_flutter_app_ready" event.
  void onAppInitialized();
  /// Called when the theme changes.
  ///
  /// Synchronizes the Flutter theme with the JavaScript preloader by
  /// dispatching a theme change event with the new color values.
  void onThemeChanged(ThemeData theme);
}
```
