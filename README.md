## Overview

The app implements a complete **local authentication flow** (sign up, login, and session persistence) using **MobX** for reactive state management and **SharedPreferences** for local storage.

The focus of this project is not only functionality, but also **code structure**, **scalability**, and **UI polish**.

---

## Architecture

The project is structured using a **layered architecture**:

- **UI (Presentation)**  
  Screens and widgets responsible only for rendering state.

- **State (MobX Stores)**  
  Manages application and authentication state in a reactive way.

- **Data Layer**  
  Handles local storage access and authentication logic via repositories.

- **Models & Utils**  
  Domain models and reusable helper utilities.

This separation keeps business logic out of widgets and makes the app easy to extend or connect to a real backend in the future.

---

## Why this approach

I intentionally avoided shortcuts such as putting logic inside widgets or directly accessing storage from the UI. Instead, I treated this as a small but realistic mobile application, focusing on:

- **Maintainability**
- **Predictable state flow**
- **Responsive design**
- **Clean separation of concerns**
