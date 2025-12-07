# Лабораторная работа №3. Задание 4: C4 Model

**Цель:** Описание архитектуры системы с использованием подхода C4 Model.

Архитектура представлена на трех уровнях детализации:
1.  **Context:** Общий контекст системы и её связи с внешним миром.
2.  **Container:** Высокоуровневая техническая архитектура (приложения, БД).
3.  **Component:** Внутреннее устройство основного контейнера (Backend API).

---

## 1. System Context Diagram (Уровень 1)

Показывает "большую картину": кто пользуется системой и с какими внешними системами она интегрируется.

```plantuml
@startuml
' C4_Custom.puml - Simplified C4 Model macros
!define C4_PERSON_BG_COLOR #08427B
!define C4_SYSTEM_BG_COLOR #1168BD
!define C4_EXTERNAL_BG_COLOR #999999

skinparam defaultTextAlignment center
skinparam wrapWidth 200
skinparam maxMessageSize 150

skinparam rectangle {
    StereotypeFontSize 12
    shadowing false
    FontColor #FFFFFF
}

skinparam rectangle<<Person>> {
    BackgroundColor C4_PERSON_BG_COLOR
    BorderColor #073B6F
}

skinparam rectangle<<System>> {
    BackgroundColor C4_SYSTEM_BG_COLOR
    BorderColor #3C7FC0
}

skinparam rectangle<<SystemExt>> {
    BackgroundColor C4_EXTERNAL_BG_COLOR
    BorderColor #8A8A8A
}

!define Person(alias, label, desc="") rectangle "==label\n\n //desc//" as alias <<Person>>
!define System(alias, label, desc="") rectangle "==label\n\n //desc//" as alias <<System>>
!define System_Ext(alias, label, desc="") rectangle "==label\n\n //desc//" as alias <<SystemExt>>
!define Rel(from, to, label) from --> to : label

title C4 Model: System Context (Level 1)

Person(passenger, "Пассажир", "Покупает билеты и просматривает расписание")
Person(admin, "Администратор", "Управляет рейсами и расписанием")

System(ticket_system, "Система ЖД Билетов", "Позволяет искать, бронировать и покупать билеты онлайн")

System_Ext(payment_gateway, "Платежный шлюз", "Обрабатывает платежи по картам")
System_Ext(email_system, "Email Сервис", "Отправляет билеты и уведомления")
System_Ext(railway_db, "БД Вокзала (Legacy)", "Существующая система учета поездов")

Rel(passenger, ticket_system, "Ищет рейсы, покупает билеты")
Rel(admin, ticket_system, "Добавляет маршруты, смотрит отчеты")

Rel(ticket_system, payment_gateway, "Инициирует транзакции")
Rel(ticket_system, email_system, "Отправляет письма")
Rel(ticket_system, railway_db, "Синхронизирует расписание")

Rel(payment_gateway, ticket_system, "Подтверждает оплату")
@enduml
```

---

## 2. Container Diagram (Уровень 2)

Показывает, из каких технических блоков (контейнеров) состоит система и как они общаются.

```plantuml
@startuml
' C4_Custom.puml - Simplified C4 Model macros
!define C4_PERSON_BG_COLOR #08427B
!define C4_CONTAINER_BG_COLOR #438DD5
!define C4_EXTERNAL_BG_COLOR #999999

skinparam defaultTextAlignment center
skinparam wrapWidth 200
skinparam maxMessageSize 150

skinparam rectangle {
    StereotypeFontSize 12
    shadowing false
    FontColor #FFFFFF
}

skinparam rectangle<<Person>> {
    BackgroundColor C4_PERSON_BG_COLOR
    BorderColor #073B6F
}

skinparam rectangle<<SystemExt>> {
    BackgroundColor C4_EXTERNAL_BG_COLOR
    BorderColor #8A8A8A
}

skinparam rectangle<<Container>> {
    BackgroundColor C4_CONTAINER_BG_COLOR
    BorderColor #3C7FC0
}

skinparam database<<Database>> {
    BackgroundColor C4_CONTAINER_BG_COLOR
    BorderColor #3C7FC0
    FontColor #FFFFFF
}

!define Person(alias, label, desc="") rectangle "==label\n\n //desc//" as alias <<Person>>
!define System_Ext(alias, label, desc="") rectangle "==label\n\n //desc//" as alias <<SystemExt>>
!define Container(alias, label, tech, desc="") rectangle "==label\n//<size:12>[tech]</size>//\n\n //desc//" as alias <<Container>>
!define ContainerDb(alias, label, tech, desc="") database "==label\n//<size:12>[tech]</size>//\n\n //desc//" as alias <<Database>>
!define Rel(from, to, label, tech="") from --> to : label + "\n[" + tech + "]"

title C4 Model: Container (Level 2)

Person(passenger, "Пассажир", "Пользователь приложения")

rectangle "Система ЖД Билетов" {
    Container(web_app, "Веб-приложение", "React, TypeScript", "Интерфейс для покупки билетов через браузер")
    Container(mobile_app, "Мобильное приложение", "Flutter", "Нативное приложение для iOS/Android")
    
    Container(api_gateway, "API Gateway", "Nginx / Golang", "Маршрутизация запросов, авторизация")
    
    Container(backend_api, "Backend API", "Golang / Gin", "Бизнес-логика: поиск, заказы, билеты")
    
    ContainerDb(database, "Database", "PostgreSQL", "Хранит пользователей, заказы, рейсы")
    ContainerDb(cache, "Cache", "Redis", "Кэширует расписание и сессии")
}

System_Ext(payment_gateway, "Платежный шлюз", "Банковский API")
System_Ext(email_system, "Email Сервис", "SMTP Provider")

Rel(passenger, web_app, "Использует", "HTTPS")
Rel(passenger, mobile_app, "Использует", "HTTPS")

Rel(web_app, api_gateway, "API calls", "JSON/HTTPS")
Rel(mobile_app, api_gateway, "API calls", "JSON/HTTPS")

Rel(api_gateway, backend_api, "Proxies requests", "gRPC/HTTP")

Rel(backend_api, database, "Reads/Writes", "SQL/TCP")
Rel(backend_api, cache, "Reads/Writes", "RESP/TCP")

Rel(backend_api, payment_gateway, "Process payments", "JSON/HTTPS")
Rel(backend_api, email_system, "Send emails", "SMTP")
@enduml
```

---

## 3. Component Diagram (Уровень 3)

Детализирует структуру Backend API, показывая основные контроллеры, сервисы и репозитории.

```plantuml
@startuml
' C4_Custom.puml - Simplified C4 Model macros
!define C4_CONTAINER_BG_COLOR #438DD5
!define C4_COMPONENT_BG_COLOR #85BBF0

skinparam defaultTextAlignment center
skinparam wrapWidth 200
skinparam maxMessageSize 150

skinparam rectangle {
    StereotypeFontSize 12
    shadowing false
    FontColor #FFFFFF
}

skinparam rectangle<<Container>> {
    BackgroundColor C4_CONTAINER_BG_COLOR
    BorderColor #3C7FC0
}

skinparam database<<Database>> {
    BackgroundColor C4_CONTAINER_BG_COLOR
    BorderColor #3C7FC0
    FontColor #FFFFFF
}

skinparam rectangle<<Component>> {
    BackgroundColor C4_COMPONENT_BG_COLOR
    BorderColor #78A8D8
    FontColor #000000
}

!define Container(alias, label, tech, desc="") rectangle "==label\n//<size:12>[tech]</size>//\n\n //desc//" as alias <<Container>>
!define ContainerDb(alias, label, tech, desc="") database "==label\n//<size:12>[tech]</size>//\n\n //desc//" as alias <<Database>>
!define Component(alias, label, tech, desc="") rectangle "==label\n//<size:12>[tech]</size>//\n\n //desc//" as alias <<Component>>
!define Rel(from, to, label) from --> to : label

title C4 Model: Component (Level 3) - Backend API

Container(api_gateway, "API Gateway", "Golang", "Входящие запросы")
ContainerDb(database, "Database", "PostgreSQL", "Хранение данных")

rectangle "Backend API Container" {
    Component(auth_controller, "Auth Controller", "Go", "Обработка входа/регистрации")
    Component(search_controller, "Search Controller", "Go", "Обработка поиска рейсов")
    Component(order_controller, "Order Controller", "Go", "Создание заказов")
    
    Component(search_service, "Search Service", "Go", "Логика поиска и фильтрации")
    Component(order_service, "Order Service", "Go", "Логика бронирования и покупки")
    Component(payment_service, "Payment Service", "Go", "Интеграция с платежным шлюзом")
    
    Component(route_repo, "Route Repository", "Go", "Доступ к таблицам маршрутов")
    Component(order_repo, "Order Repository", "Go", "Доступ к таблицам заказов")
}

Rel(api_gateway, auth_controller, "Login request")
Rel(api_gateway, search_controller, "GET /trains")
Rel(api_gateway, order_controller, "POST /order")

Rel(search_controller, search_service, "Uses")
Rel(order_controller, order_service, "Uses")

Rel(search_service, route_repo, "Finds routes")
Rel(order_service, order_repo, "Saves order")
Rel(order_service, payment_service, "Initiates payment")
Rel(order_service, route_repo, "Checks availability")

Rel(route_repo, database, "SQL Select")
Rel(order_repo, database, "SQL Insert")
@enduml
```

