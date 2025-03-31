# 💎 Diamond Selection App

A Flutter application for browsing, filtering, and selecting diamonds, built using **Clean Architecture** with **BLoC state management** and **persistent cart storage**.

## 📁 Project Structure

The app follows a **feature-based** structure with **Clean Architecture**, dividing code into layers:

```
lib/
│── core/                     # Common utilities, helpers, and constants
│── features/diamond/          # Feature-specific code
│   ├── data/                  # Data layer (models, repositories, local storage)
│   │   ├── models/            # Data models (DiamondModel, etc.)
│   │   ├── repositories/      # Repository implementations
│   │   ├── sources/           # Data sources (local storage, API handling)
│   ├── domain/                # Domain layer (entities, use cases)
│   │   ├── entities/          # Core business entities (Diamond, etc.)
│   │   ├── repositories/      # Repository interfaces
│   │   ├── usecases/          # Business logic (FilterDiamonds, AddToCart, etc.)
│   ├── presentation/          # UI and state management
│   │   ├── bloc/              # BLoC for managing UI state
│   │   ├── pages/             # Screens (FilterScreen, ResultScreen, CartScreen)
│   │   ├── widgets/           # UI components (DiamondCard, FilterOptions)
│── main.dart                  # App entry point
```

---

## ⚡ State Management

This app uses **BLoC (Business Logic Component)** for state management.  
Each feature has a **Bloc** that handles UI interactions and updates the state accordingly.

### **BLoCs in the App**

1. **DiamondBloc** → Handles diamond filtering & sorting
2. **CartBloc** → Manages the cart (add, remove, persist data)

### **Example Bloc Flow (Filtering Diamonds)**

1️⃣ **Event Triggered:** User applies filters → `FilterDiamondsEvent` is dispatched.  
2️⃣ **Bloc Processes:** `DiamondBloc` fetches filtered diamonds from the repository.  
3️⃣ **State Updated:** `DiamondLoaded` state updates the UI with results.

---

## 💾 Persistent Storage

The cart data is stored locally using **Hive**.  
This ensures that the selected diamonds remain in the cart even after the app is closed.

### **Cart Storage Implementation**

- **Hive Box:** Stores a list of selected diamonds.
- **CartRepository:** Saves, loads, and removes items from Hive storage.
- **CartBloc:** Manages cart actions and updates the UI.

### **Example: Saving to Cart**

1️⃣ User clicks **Add to Cart** → `AddToCartEvent` dispatched  
2️⃣ `CartBloc` updates state and saves the diamond in **Hive**  
3️⃣ When the cart screen opens, `LoadCartEvent` fetches saved diamonds

---

## 🚀 Features

✅ **Filter Diamonds** by carat, lab, shape, color, clarity  
✅ **Sort Diamonds** by price or carat size  
✅ **View Results** in a structured list  
✅ **Add/Remove Diamonds** from the cart  
✅ **Persistent Cart Storage** (remains saved after app restart)  
✅ **Summary in Cart**:
- **Total Carat**
- **Total Price**
- **Average Price per Carat**
- **Average Discount**

---

## 📌 Navigation (GoRouter)

- `/` → **Filter Diamonds Screen**
- `/result` → **Filtered Results Screen**
- `/cart` → **Cart Screen**

Navigation is handled using **GoRouter** for smooth screen transitions.

---

## 🛠️ Tech Stack

- **Flutter** (Dart)
- **BLoC** (State Management)
- **Hive** (Local Storage)
- **GoRouter** (Navigation)

---


