# Lab 8: Frontend UI Development (Web & Mobile)

## Goal
Implement the user interface for both Web and Mobile applications using mock data. No API integration yet.

## Tech Stack
- **Web**: React (Vite)
- **Mobile**: Flutter
- **CI/CD**: GitHub Actions
- **Code Quality**: ESLint (Web), flutter_lints (Mobile)

## Tasks

- [ ] **Web Application (React)**
    - [ ] **Project Setup**
        - [ ] Initialize React project (`npm create vite@latest`)
        - [ ] Setup routing (`react-router-dom`)
        - [ ] Setup UI library (e.g., Material UI or Tailwind CSS)
    - [ ] **UI Implementation**
        - [ ] **Home/Search Page**: Search form for routes
        - [ ] **Search Results**: List of available trains (Mock data)
        - [ ] **Seat Selection**: Visual representation of carriage/seats
        - [ ] **Booking Form**: Passenger details input
        - [ ] **User Dashboard**: List of orders (Mock data)
    - [ ] **State Management**
        - [ ] Implement local state for cart/booking process

- [ ] **Mobile Application (Flutter)**
    - [ ] **Project Setup**
        - [ ] Initialize Flutter project (`flutter create`)
        - [ ] Setup routing (`go_router` or named routes)
    - [ ] **UI Implementation**
        - [ ] **Home Screen**: Search functionality
        - [ ] **Results Screen**: List view of trains
        - [ ] **Detail Screen**: Train details and seat selection
        - [ ] **Profile/Orders Screen**: List of tickets
    - [ ] **State Management**
        - [ ] Basic state management (Provider or Riverpod) for mock data

- [ ] **CI/CD & Quality**
    - [ ] **Web**: GitHub Action for build and lint (`npm run lint`, `npm run build`)
    - [ ] **Mobile**: GitHub Action for analysis (`flutter analyze`, `flutter test`)

- [ ] **Reporting**
    - [ ] Create a report with screenshots of both applications.
