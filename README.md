# 📂 Online File Transfer App

An **Online File Transfer App** built with **Flutter** that allows users to **pick, upload, preview, and share files** securely using **Firebase**.  
This app is designed to make file sharing **simple, fast, and reliable**, accessible from any device.

> ⚠️ **Note:** This app is currently under active development. New features and improvements are being added regularly.

---

## 🚀 Features

- 🔐 **Google Authentication** —  
  Secure login and signup through Google using Firebase Authentication and the `google_sign_in` package.

- 👤 **Profile Screen with Live Updates** —  
  Displays the signed-in user's **name, email, and profile photo** in real-time using **StreamBuilder** from Firestore.

- ✏️ **Update Account Name** —  
  Users can edit their name in **Account Settings**, and the change automatically updates in **Firestore** and reflects instantly in the UI through **GetX**.

- 📁 **File Picker Integration** —  
  Users can select **any file type** (PDF, image, video, document, etc.) using the `file_picker` package.

- 🧩 **Dynamic File Icons & Previews** —
    - 📄 PDF files display a PDF icon and file name.
    - 🖼️ Image files show a full preview.
    - 🎬 Video files automatically generate a **thumbnail** using `video_thumbnail`.
    - 📦 Other files show relevant icons with their file names.

- ☁️ **Cloud Firestore** —  
  Stores user details and file metadata, ensuring fast and reliable data retrieval.

- ⚙️ **Firebase Authentication + Firestore Sync** —  
  User sessions and profile data are securely managed through Firebase Authentication and Firestore integration.

- ⚡ **State Management with GetX** —  
  Efficiently handles navigation, reactivity, and data updates across the entire app.

- 🌐 **Internet Connectivity Check** —  
  Uses `connectivity_plus` to detect online/offline status:
    - When **offline**, a custom “No Internet” container is shown.
    - When **online**, the app resumes normal functionality automatically.

- 📤 **File Sharing** —  
  Using `share_plus`, users can share selected files (images, PDFs, videos, etc.) directly via apps like WhatsApp, Gmail, or Telegram — not just URLs.

- 🕓 **Splash Screen with Progress Steps** —  
  Features a **4-step linear progress bar** implemented using `linear_progress_bar`, guiding users smoothly into the Sign-In screen.

- 🎨 **Responsive Modern UI** —  
  Clean, minimalistic interface that adapts beautifully to different screen sizes and orientations.

---

## 🧩 Packages Used

| Package | Version | Description & Implementation |
|----------|----------|------------------------------|
| **`firebase_core`** | ^4.1.1 | Initializes Firebase connection. Implemented in `main.dart` before any Firebase features are used. |
| **`firebase_auth`** | ^6.1.0 | Handles all authentication logic (login, logout, and session tracking) using Firebase Auth. |
| **`google_sign_in`** | ^6.2.0 | Enables secure Google Sign-In. Integrated in the authentication controller to manage user login and fetch profile details. |
| **`cloud_firestore`** | ^6.0.2 | Stores and retrieves user information and file metadata. Integrated with `StreamBuilder` for live UI updates. |
| **`get`** | ^4.7.2 | Used for state management, dependency injection, and navigation. Helps maintain reactive updates and clean code structure. |
| **`file_picker`** | ^10.3.3 | Lets users select any file type from their device storage. Used in the upload feature to access files locally. |
| **`video_thumbnail`** | ^0.5.6 | Automatically generates thumbnail previews for video files. Used in file display UI for better visual experience. |
| **`share_plus`** | ^10.0.1 | Allows users to share files directly from the app to other apps, such as WhatsApp, Telegram, or Email. |
| **`connectivity_plus`** | ^5.0.1 | Detects real-time internet connectivity changes. Displays an offline container when the user loses connection. |
| **`linear_progress_bar`** | ^1.2.0 | Used on the splash screen to show a smooth, 4-step progress animation before navigation to the next screen. |

---

## 🧠 Implementation Highlights

- ✅ **Splash Flow:**  
  Implemented using a **GetX controller** with a timed **linear progress bar** that moves through 4 steps before navigating to the sign-in screen.

- ✅ **Authentication Flow:**
    - Users can sign in via Google.
    - User info (name, email, photo) is automatically stored or updated in Firestore.
    - Existing users are redirected straight to the home screen.

- ✅ **Profile Management:**  
  The app uses **Firestore streams** to update user data in real time. When the name is updated, it refreshes instantly throughout the app.

- ✅ **File Handling:**
    - Uses `file_picker` to select files.
    - Dynamically detects file type (PDF, image, video, etc.).
    - Displays appropriate icons or previews, and generates **video thumbnails** automatically.

- ✅ **Offline Handling:**
    - `connectivity_plus` monitors internet connection status.
    - Displays a **“No Internet”** message or container when the user is disconnected.

- ✅ **File Sharing:**
    - Implemented using `share_plus`.
    - Supports full file sharing (e.g., sending image, PDF, or video files directly).
    - Ensures smooth sharing experience across different apps.

---

## ⚙️ Tech Stack

- **Framework:** Flutter
- **Backend:** Firebase (Auth + Firestore)
- **State Management:** GetX
- **Storage:** Cloud Firestore
- **Platform:** Android (iOS and Web coming soon)
