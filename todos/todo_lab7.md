# Lab 7: Backend Development & DevOps

## Goal
Implement the core backend functionality, document the API, and set up CI/CD pipelines.

## Tech Stack
- **Language**: Go (Golang)
- **Framework**: Gin or Echo (Standard for Go APIs)
- **Database**: PostgreSQL
- **CI/CD**: GitHub Actions
- **Code Quality**: SonarQube / GolangCI-Lint

## Tasks

- [ ] **Project Setup**
    - [ ] Initialize Go module (`go mod init`)
    - [ ] Setup project structure (Standard Go Layout: `cmd`, `internal`, `pkg`)
    - [ ] Configure Docker/Docker Compose for local development (App + DB)

- [ ] **Database Implementation**
    - [ ] Define database schema (migrations) for:
        - [ ] Users
        - [ ] Passengers
        - [ ] Orders
        - [ ] Tickets
        - [ ] Trains/Carriages/Seats
        - [ ] Routes/Stations
    - [ ] Implement repository pattern for database access

- [ ] **API Implementation**
    - [ ] **Auth Module**
        - [ ] `POST /auth/register`
        - [ ] `POST /auth/login` (JWT)
    - [ ] **User Module**
        - [ ] `GET /users/me`
        - [ ] `PUT /users/me`
    - [ ] **Core Business Logic**
        - [ ] `GET /routes/search`
        - [ ] `POST /orders`
        - [ ] `GET /orders`
    - [ ] **Admin Module**
        - [ ] CRUD for Routes/Trains

- [ ] **Documentation**
    - [ ] Generate Swagger/OpenAPI documentation (using `swag` or similar)

- [ ] **CI/CD & Quality**
    - [ ] Create GitHub Actions workflow (`.github/workflows/ci.yml`)
    - [ ] Configure build step
    - [ ] Configure test step (`go test ./...`)
    - [ ] Configure linter (GolangCI-Lint)
    - [ ] Integrate SonarQube (optional/if feasible) or similar quality gate

- [ ] **Reporting**
    - [ ] Create a report documenting the implementation and CI/CD setup.
