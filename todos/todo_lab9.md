# Lab 9: Integration & Testing

## Goal
Integrate the Web and Mobile applications with the Backend API, ensuring full end-to-end functionality. Perform comprehensive testing.

## Tech Stack
- **Backend**: Go (Gin/Echo)
- **Web**: React (Vite)
- **Mobile**: Flutter
- **Testing**: Go Test, Jest/Vitest, Flutter Test

## Tasks

- [ ] **API Integration**
    - [ ] **Web Application**
        - [ ] Replace mock data with API calls (`fetch` or `axios`)
        - [ ] Implement Authentication (Login/Register) with JWT storage
        - [ ] Handle API errors and loading states
    - [ ] **Mobile Application**
        - [ ] Replace mock data with API calls (`http` or `dio` package)
        - [ ] Implement Secure Storage for tokens (`flutter_secure_storage`)
        - [ ] Handle network connectivity issues

- [ ] **End-to-End Features**
    - [ ] **Booking Flow**: Complete flow from Search -> Select -> Pay -> Ticket
    - [ ] **User Profile**: View and edit real user data
    - [ ] **Order History**: View actual past orders

- [ ] **Testing**
    - [ ] **Backend**:
        - [ ] Unit tests for services
        - [ ] Integration tests for API endpoints
    - [ ] **Frontend (Web)**:
        - [ ] Unit tests for components
    - [ ] **Mobile**:
        - [ ] Widget tests for critical screens

- [ ] **Deployment & Finalization**
    - [ ] Ensure all CI/CD pipelines pass
    - [ ] Verify Docker Compose setup runs the full stack locally
    - [ ] Finalize documentation and report
