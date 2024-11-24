# red_zone

“RedZone” - Real-Time Natural Disasters Prevention Alerts and Risk Management Mobile Application

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Project Start 2024.01.23

### Native Splash Screen setup

```agsl
 flutter pub add flutter_native_splash
 flutter pub run flutter_native_splash:create --path=splash.yaml
```

For the Splash screen size is 460 x Width & Height where as the icon inside is only 250 x width & height. This means, the icon should have a space around it. For the Onboarding you can use any size because we are making sure to assign only 60% width to the total screen.

# Primary_header_container.dart - Special Note

- <b>We cannot create more than one POSITIONED() widget inside the STACK() widget. It will error occurred. So that we wrap STACK() with SIZEDBOX(); widget to get rid of this error.</b>

## Before

```agsl
 @override
  Widget build(BuildContext context) {
    return TCustomCurvedWidget(
      child: Container(
        color: TColors.primary,
        padding: const EdgeInsets.all(0),
        /// -- If [size.isFinite': is not true.in stack] error occurred -> Read README.md file
        child: SizedBox(
          height: 400,
          child: Stack(
            children: [
              Positioned(
                  top: -150,
                  right: -250,
                  child: TCircularContainer(
                      backgroundColor: TColors.textWhite.withOpacity(0.1))),
              Positioned(
                  top: 100,
                  right: -300,
                  child: TCircularContainer(
                      backgroundColor: TColors.textWhite.withOpacity(0.1))),
            ],
          ),
        ),
      ),
    );
  }
```

## After

```agsl
@override
  Widget build(BuildContext context) {
    return TCustomCurvedWidget(
      child: Container(
        color: TColors.primary,
        padding: const EdgeInsets.only(bottom: 0),

        /// -- If [size.isFinite': is not true.in stack] error occurred -> Read README.md file
        constraints: const BoxConstraints(minHeight: 400),
        
        child: Stack(
          children: [
            Positioned(
                top: -150,
                right: -250,
                child: TCircularContainer(
                    backgroundColor: TColors.textWhite.withOpacity(0.1))),
            Positioned(
                top: 100,
                right: -300,
                child: TCircularContainer(
                    backgroundColor: TColors.textWhite.withOpacity(0.1))),
            child,
          ],
        ),
      ),
    );
  }
```

# Quick fix dart errors command

- It can used to remove unused imports, add necessary const keywords.

```agsl

dart fix --apply

```

# Image Carousel design

```agsl

pub add carousel_slider

```
### Image container set
```agsl

Padding(
  padding: const EdgeInsets.all(TSizes.defaultSpace),
  child: Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(TSizes.md)),
    child: ClipRRect(borderRadius: BorderRadius.circular(TSizes.md),
       child: const Image( image: AssetImage(TImages.banner1)),
       ),
    ),
)
```

# Google SignIn adding

```agsl
flutter pub add google_sign_in   
```

# SHA1, SHA256

```agsl
keytool -list -v -keystore "C:\Users\Avishka Dulanjana\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android
```

# Push Notification Setup

### Need to add this packages

```agsl
flutter pub add firebase_messaging
npm install -g firebase-tools
```

## Then firebase connect to the project

```agsl
1. You have to go to firebase and enable messaging and functions
2. functions enable as you PAY AS GO feature and enable functions feature to your flutter project
3. Then you can use it after few steps follows
```

#### This code use to add nessassary files to the project as use Javascrip with node modules =>

```agsl
firebase init  
```
#### Javascript code for chat push notification index.js on functions file
```agsl
const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

// Cloud Firestore triggers ref: https://firebase.google.com/docs/functions/firestore-events
exports.myFunction = functions.firestore
// This "Chat" is firebase database Table name
  .document("Chat/{messageId}")
  .onCreate((snapshot, context) => {
    // Return this function's promise, so this ensures the firebase function
    // will keep running, until the notification is scheduled.
    return admin.messaging().sendToTopic("Chat", {
      // Sending a notification message.
      notification: {
      // This is Chat Table datas waht you want to show
        title: snapshot.data()["username"],
        body: snapshot.data()["text"],
        clickAction: "FLUTTER_NOTIFICATION_CLICK",
      },
    });
  });

```
#### This code use after function write and deploy it to firebase =>

```agsl
firebase deploy 
```

### manifest file change

```
Queries section added above application section to mail connect

    <!-- Provide required visibility configuration for API level 30 and above -->
    <queries>
        <!-- If your app checks for SMS support -->
        <intent>
            <action android:name="android.intent.action.VIEW" />
            <data android:scheme="sms" />
        </intent>
        <!-- If your app checks for call support -->
        <intent>
            <action android:name="android.intent.action.VIEW" />
            <data android:scheme="tel" />
        </intent>
        <!-- If your application checks for inAppBrowserView launch mode support -->
        <intent>
            <action android:name="android.support.customtabs.action.CustomTabsService" />
        </intent>
    </queries>
```