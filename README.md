# 📂 Online File Transfer App

An **Online File Transfer App** built with **Flutter** that allows users to **pick, upload, and share files** securely using **Firebase**.  
This app is designed to make file sharing simple, fast, and reliable — accessible from any device.

> ⚠️ **Note:** This app is currently under active development. It’s not yet complete, and new features are being added regularly.

---

## 🚀 Features

- 🔐 **Google Authentication** — Secure login and signup using Google.
- 👤 **Profile Screen** — Displays the signed-in user's **name, email, and photo** using **StreamBuilder** directly from Firestore.
- ✏️ **Update Account Name** — Users can update their name in the **Account Settings**, and it will automatically update in Firestore and the UI.
- 📁 **File Picker Integration** — Users can select **any type of file** (PDF, image, document, etc.).
- 🧩 **Dynamic File Icons & Previews** —
    - If a **PDF** is selected → a PDF icon and file name are shown.
    - If an **image** is selected → the full image preview is displayed.
    - Other files show type-appropriate icons and names.
- ☁️ **Cloud Firestore** — Used to store user details.
- 🕓 **Splash Screen with Progress** — A linear progress bar runs through **4 steps**, then navigates to the **Sign-In screen**.
- ⚡ **State Management with GetX** — Efficient and reactive app flow.
- 🎨 **Responsive UI** — Clean, modern design that adapts to different screen sizes.

---

## 🧩 Packages Used

| Package | Version | Description                                                                          |
|----------|----------|--------------------------------------------------------------------------------------|
| `firebase_core` | ^4.1.1 | Initializes and connects Firebase to the app.                                        |
| `firebase_auth` | ^6.1.0 | Handles Firebase Authentication.                                                     |
| `google_sign_in` | ^6.2.0 | Enables Google Sign-In functionality.                                                |
| `cloud_firestore` | ^6.0.2 | Stores user and file metadata in Firestore.                                          |
| `get` | ^4.7.2 | Manages state and navigation across the app.                                         |
| `file_picker` | ^10.3.3 | Lets users select any type of file from their device.                                |
| `linear_progress_bar` | ^1.2.0 | Displays a 4-step linear bar on the splash screen before moving to the Sign-In page. |

---


