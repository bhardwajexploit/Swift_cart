# SwiftCart — iOS-Styled Flutter Shopping App

SwiftCart is a Flutter e-commerce application designed with an **iOS-native Cupertino UI**, built using **GetX state management** and an **MVVM-inspired architecture**.

The application supports:

- Firebase-based user authentication (Register, Login, Profile)
- Product listing via the **Platzi Fake Store REST API**
- Add-to-cart & cart total calculation
- Profile update & secure session handling
- Reactive UI using GetX Observables
- iOS-styled navigation using `CupertinoTabScaffold`

---

## 🚀 Tech Stack & Project Details

| Component | Stack |
|--------|------|
| Flutter Version | **Flutter 3.x.x (Latest Stable)** |
| Dart Version | **3.x.x** |
| State Management | **GetX** |
| Architecture Pattern | **MVVM (Modular, Layered, Controller + Repo)** |
| Backend Auth | **Firebase Authentication** |
| Remote API | **Platzi Fake Store API** |
| UI Theme | **Cupertino (iOS-Style)** |
| Navigation | **GetX Navigation + Cupertino Tabs** |

---

## 🎥 Demo Video

The full working demo has been shared securely via Google Drive.

> (Video link provided separately to maintain confidentiality)

---

## 🔐 Firebase Configuration

Firebase is used for:

- User Registration
- Login Authentication
- Profile Updates
- Session Handling

The Firebase configuration file is excluded from the repository for security:


To run the project locally, place the file at:



---

## 🛍 Product API — Platzi Fake Store

SwiftCart uses the following public API for product listing:

> Platzi Fake Store API — mock commerce REST API for prototyping

Data is consumed via:

- Repository Layer
- Dashboard & Product Controllers
- GetX Reactive Streams
- Clean UI Binding

---

## 🖼 Screenshots

Screenshots are stored in:

| Splash                                     | Welcome                                     |
|--------------------------------------------|---------------------------------------------|
| ![Splash](assets/screenshots/IMG_8031.PNG) | ![Welcome](assets/screenshots/IMG_8032.PNG) |

| Sign Up                                    | Sign In                                    |
|--------------------------------------------|--------------------------------------------|
| ![SignUp](assets/screenshots/IMG_8033.PNG) | ![SignIn](assets/screenshots/IMG_8034.PNG) |

| Product List                                 | Cart                                     |
|----------------------------------------------|------------------------------------------|
| ![Products](assets/screenshots/IMG_8039.PNG) | ![Cart](assets/screenshots/IMG_8041.PNG) |

| Profile                                     |
|---------------------------------------------|
| ![Profile](assets/screenshots/IMG_8042.PNG) |

---

## 🏗 Project Folder Structure (MVVM + GetX)


**Layers Breakdown**

- `model/` — Data models
- `data/remote/` — API + Firebase repos
- `screens/*/controller` — View Logic (GetX)
- `screens/*/view` — UI Pages
- `widgets/` — Reusable UI Components

---

## ⚙️ Setup & Run The Project

Install dependencies:


---

## 🍏 iOS Setup Notes

Place Firebase plist file:


Status:

- No build errors
- Firebase auth functional
- API works correctly
- Cart logic validated
- Navigation stable across tabs
- Tested on real iOS device

---

## 📌 Additional Notes

- Firebase credentials & demo video are stored securely outside the repository
- Repository contains **only required source files**
- Screenshots provided for UI demonstration
- Project structure follows **scalable modular pattern**

---

## 👤 Author

**Ayush Bhardwaj**  
GitHub: https://github.com/bhardwajexploit

---

## ⭐ If you like this project

Consider starring the repository. Feedback is welcome.


