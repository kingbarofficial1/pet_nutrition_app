
# Pet Nutrition App

Modern Flutter app with Light/Dark mode, English + Hindi + Marathi + Kannada + Tamil, demo pets, local save, Add/Edit/Delete pets. Play Store–ready.

## Build on Codemagic (no local setup)
1. Push this folder to a new GitHub repo.
2. In Codemagic → add app from repository.
3. Select workflow **android_ios_build** (reads `codemagic.yaml`).
4. Start build → download **app-debug.apk** (Artifacts). For Play Store upload **app-release.aab**.

## Local run (optional)
- Install Flutter SDK → run:
```
flutter pub get
flutter run
```

## Package ID
- Default: `com.example.pet_nutrition` (change later in `android/app/build.gradle`).
