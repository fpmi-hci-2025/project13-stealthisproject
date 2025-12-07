# Спецификация системы "ЖД Вокзал Минск" (Лабораторная работа №3)

**Цель:** Разработать спецификацию системы с использованием языка моделирования PlantUML.

---

## 1. Диаграмма вариантов использования (Use Case Diagram)

Диаграмма описывает основные функциональные возможности системы и взаимодействия с действующими лицами (акторами).

```plantuml
@startuml 01
left to right direction
actor "Пассажир" as Passenger
actor "Администратор" as Admin
actor "Кассир" as Cashier

rectangle "Система продажи ЖД билетов" {
  usecase "Регистрация" as UC1
  usecase "Авторизация" as UC2
  usecase "Поиск рейса" as UC3
  usecase "Просмотр деталей рейса" as UC4
  usecase "Выбор места на схеме" as UC5
  usecase "Покупка билета" as UC6
  usecase "Оплата заказа" as UC7
  usecase "Просмотр истории поездок" as UC8
  usecase "Управление рейсами" as UC9
  usecase "Просмотр всех заказов" as UC10
  usecase "Продажа билета через кассу" as UC11
  usecase "Возврат билета" as UC12
}

Passenger --> UC1
Passenger --> UC2
Passenger --> UC3
Passenger --> UC4
Passenger --> UC5
Passenger --> UC6
Passenger --> UC8
Passenger --> UC12

UC6 ..> UC7 : <<include>>
UC6 ..> UC5 : <<include>>
UC6 ..> UC2 : <<include>>

Admin --> UC2
Admin --> UC9
Admin --> UC10

Cashier --> UC2
Cashier --> UC3
Cashier --> UC11
Cashier --> UC12

UC11 ..> UC7 : <<include>>
@enduml
```

### Акторы
*   **Пассажир**: Пользователь, желающий найти и купить билет.
*   **Администратор**: Сотрудник, управляющий данными системы (рейсы, пользователи).
*   **Кассир**: Сотрудник, оформляющий билеты на вокзале.

### Сценарии вариантов использования

#### Сценарий 1: Покупка билета (Основной)
**Название:** Покупка билета онлайн.
**Действующее лицо:** Пассажир.
**Предусловие:** Пассажир находится на сайте/в приложении.
**Постусловие:** Билет куплен, отправлен на почту, место в вагоне занято.

**Основной поток:**
1.  Пассажир выбирает вариант использования "Поиск рейса".
2.  Система отображает форму поиска.
3.  Пассажир вводит станцию отправления, назначения и дату.
4.  Система отображает список доступных поездов.
5.  Пассажир выбирает подходящий поезд.
6.  Система отображает схему вагонов (ВИ "Выбор места на схеме").
7.  Пассажир выбирает свободное место.
8.  Система запрашивает подтверждение и переход к оплате.
9.  Пассажир подтверждает выбор.
10. Если пользователь не авторизован, Система запрашивает вход (ВИ "Авторизация").
11. Пассажир переходит к оплате (ВИ "Оплата заказа").
12. Система подтверждает успешную транзакцию.
13. Система генерирует билет и отправляет его пользователю.

**Альтернативный поток (Нет мест):**
4а. Система сообщает, что билетов на выбранную дату нет.
4б. Сценарий завершается или возвращается к шагу 3.

#### Сценарий 2: Добавление рейса
**Название:** Добавление нового железнодорожного рейса.
**Действующее лицо:** Администратор.
**Предусловие:** Администратор авторизован в системе.

**Основной поток:**
1.  Администратор выбирает раздел "Управление рейсами".
2.  Система отображает список текущих рейсов.
3.  Администратор нажимает "Добавить рейс".
4.  Система отображает форму создания рейса.
5.  Администратор вводит номер поезда, тип, маршрут следования.
6.  Система проверяет корректность данных.
7.  Система сохраняет новый рейс в базе данных.
8.  Система выводит сообщение об успехе.

#### Сценарий 3: Возврат билета
**Название:** Оформление возврата билета.
**Действующее лицо:** Пассажир.
**Предусловие:** У пассажира есть купленный билет, до отправления более 1 часа.

**Основной поток:**
1.  Пассажир заходит в "Личный кабинет" -> "История поездок".
2.  Система отображает список билетов.
3.  Пассажир выбирает активный билет и нажимает "Вернуть".
4.  Система рассчитывает сумму возврата (с учетом комиссий).
5.  Пассажир подтверждает возврат.
6.  Система меняет статус билета на "Возвращен".
7.  Система инициирует возврат средств на карту.
8.  Место в вагоне снова становится свободным.

---

## 2. Диаграммы деятельности (Activity Diagrams)

### 2.1. Процесс покупки билета
Диаграмма детализирует алгоритм покупки билета пользователем, включая ветвления при ошибках или отсутствии мест.

```plantuml
@startuml
start
:Пользователь открывает сайт/приложение;
:Вводит станцию отправления и прибытия;
:Выбирает дату поездки;
:Нажимает "Найти";
if (Рейсы найдены?) then (да)
  :Система отображает список рейсов;
  :Пользователь выбирает рейс;
  :Система отображает схему вагонов;
  :Пользователь выбирает место;
  if (Пользователь авторизован?) then (нет)
    :Предложить вход или ввод данных пассажира;
    :Пользователь вводит данные;
  endif
  :Переход к оплате;
  if (Оплата успешна?) then (да)
    :Формирование билета;
    :Отправка билета на почту/в приложение;
    stop
  else (нет)
    :Сообщение об ошибке оплаты;
    stop
  endif
else (нет)
  :Сообщение "Рейсов не найдено";
  stop
endif
@enduml
```

### 2.2. Процесс добавления маршрута
Диаграмма описывает последовательность действий администратора при вводе нового рейса в систему.

```plantuml
@startuml
|Администратор|
start
:Инициирует добавление нового рейса;
:Вводит данные (номер поезда, маршрут);
|Система|
:Валидирует данные;
if (Данные корректны?) then (да)
  :Запрашивает список остановок;
  |Администратор|
  :Вводит остановки и время;
  |Система|
  :Сохраняет маршрут;
  :Создает сущности рейса в БД;
  :Подтверждает успех;
else (нет)
  :Показывает ошибки валидации;
endif
stop
@enduml
```

---

## 3. Диаграмма классов (Class Diagram)

Отображает статическую структуру системы, основные сущности (User, Ticket, Train, Route) и связи между ними (ассоциации, композиции).

```plantuml
@startuml
class User {
  +id: Long
  +email: String
  +passwordHash: String
  +role: Role
  +login()
  +register()
}

class Passenger {
  +id: Long
  +firstName: String
  +lastName: String
  +passportNumber: String
}

class Ticket {
  +id: Long
  +price: Decimal
  +purchaseDate: DateTime
  +status: TicketStatus
  +generatePDF()
}

class Order {
  +id: Long
  +orderDate: DateTime
  +totalAmount: Decimal
  +status: OrderStatus
}

class Train {
  +id: Long
  +number: String
  +type: TrainType
}

class Route {
  +id: Long
  +startStation: Station
  +endStation: Station
  +duration: Duration
}

class Station {
  +id: Long
  +name: String
  +city: String
}

class Carriage {
  +id: Long
  +number: Int
  +type: CarriageType
}

class Seat {
  +id: Long
  +number: Int
  +isOccupied: Boolean
}

User "1" -- "*" Order : creates >
Order "1" *-- "*" Ticket : contains >
Ticket "*" -- "1" Passenger : assigned to >
Ticket "*" -- "1" Seat : reserves >
Seat "*" -- "1" Carriage : belongs to >
Carriage "*" -- "1" Train : part of >
Train "*" -- "1" Route : follows >
Route "*" -- "2..*" Station : connects >
@enduml
```

### 3.1. Диаграмма объектов
Показывает пример конкретного экземпляра выполнения системы (снапшот): пользователь Анна оформила заказ №5001 с одним билетом.

```plantuml
@startuml
object "user1: User" as u1 {
  id = 101
  email = "anna@example.com"
  role = PASSENGER
}

object "order1: Order" as o1 {
  id = 5001
  orderDate = "2025-12-02 14:30"
  status = PAID
  totalAmount = 45.00
}

object "ticket1: Ticket" as t1 {
  id = 9001
  price = 45.00
  status = ACTIVE
}

object "pass1: Passenger" as p1 {
  firstName = "Anna"
  lastName = "Petrova"
}

object "train703: Train" as tr1 {
  number = "703B"
  type = INTERCITY
}

u1 -- o1 : placed
o1 -- t1 : contains
t1 -- p1 : for
t1 -- tr1 : valid for
@enduml
```

**Описание классов:**
*   **User**: Базовый класс пользователя.
*   **Passenger**: Информация о конкретном пассажире (ФИО, паспорт).
*   **Order**: Заказ, который может содержать несколько билетов.
*   **Ticket**: Единица права на проезд, связана с конкретным местом.
*   **Train/Carriage/Seat**: Иерархия физических объектов (Поезд -> Вагон -> Место).

---

## 4. Диаграммы последовательности (Sequence Diagrams)

Описывают взаимодействие объектов во времени для реализации конкретных сценариев.

### 4.1. Поиск рейса
Показывает взаимодействие UI, Сервиса поиска и Репозитория маршрутов.

```plantuml
@startuml
actor User
participant "SearchUI" as UI
participant "SearchService" as Service
participant "RouteRepository" as Repo
database "Database" as DB

User -> UI : Вводит параметры поиска (откуда, куда, дата)
activate UI
UI -> Service : findTrains(source, dest, date)
activate Service
Service -> Repo : findRoutesByStations(source, dest)
activate Repo
Repo -> DB : SQL Select
activate DB
DB --> Repo : List<Route>
deactivate DB
Repo --> Service : List<Route>
deactivate Repo

loop для каждого маршрута
    Service -> Service : checkAvailability(route, date)
end

Service --> UI : List<TrainDto>
deactivate Service
UI --> User : Отображение списка поездов
deactivate UI
@enduml
```

### 4.2. Покупка билета
Детальный поток обмена сообщениями между UI, Сервисом заказов, Платежным шлюзом и Сервисом уведомлений.

```plantuml
@startuml
actor Passenger
participant "BookingUI" as UI
participant "OrderService" as OrderSvc
participant "PaymentService" as PaySvc
participant "NotificationService" as Notify

Passenger -> UI : Нажимает "Купить"
activate UI
UI -> OrderSvc : createOrder(userId, tripDetails)
activate OrderSvc
OrderSvc -> OrderSvc : validateAvailability()
OrderSvc -> OrderSvc : reserveSeats()
OrderSvc --> UI : orderId, amount
deactivate OrderSvc

UI -> PaySvc : processPayment(orderId, cardData)
activate PaySvc
PaySvc -> PaySvc : contactBankAPI()
PaySvc --> UI : paymentSuccess
deactivate PaySvc

UI -> OrderSvc : confirmOrder(orderId)
activate OrderSvc
OrderSvc -> OrderSvc : generateTickets()
OrderSvc -> Notify : sendEmail(userId, tickets)
activate Notify
Notify --> OrderSvc : sent
deactivate Notify
OrderSvc --> UI : orderConfirmed
deactivate OrderSvc

UI --> Passenger : Отображение билета
deactivate UI
@enduml
```

### 4.3. Авторизация
Процесс входа пользователя в систему.

```plantuml
@startuml
actor User
participant "LoginUI" as UI
participant "AuthService" as Auth
database "UserDB" as DB

User -> UI : Вводит email/password
activate UI
UI -> Auth : login(email, password)
activate Auth
Auth -> DB : findUserByEmail(email)
activate DB
DB --> Auth : UserData
deactivate DB

Auth -> Auth : verifyPassword(password, hash)
alt password correct
    Auth -> Auth : generateToken()
    Auth --> UI : Token
    UI --> User : Redirect to Home
else password incorrect
    Auth --> UI : Error "Invalid credentials"
    UI --> User : Show Error
end
deactivate Auth
deactivate UI
@enduml
```

### 4.4. Добавление рейса (Админ)
Взаимодействие администратора с панелью управления и базой данных.

```plantuml
@startuml
actor Admin
participant "AdminPanel" as UI
participant "RouteService" as Service
database "Database" as DB

Admin -> UI : Вводит данные маршрута
activate UI
UI -> Service : createRoute(routeData)
activate Service
Service -> Service : validateStations(stations)
Service -> DB : saveRoute(route)
activate DB
DB --> Service : routeId
deactivate DB
Service --> UI : Success
deactivate Service
UI --> Admin : Маршрут создан
deactivate UI
@enduml
```

### 4.5. Обработка платежа
Интеграция с внешней банковской системой.

```plantuml
@startuml
actor Passenger
participant "PaymentGateway" as GW
participant "BankSystem" as Bank
participant "OrderService" as Order

Passenger -> GW : Ввод карты и подтверждение
activate GW
GW -> Bank : Authorize Transaction
activate Bank
Bank --> GW : Transaction Approved
deactivate Bank

GW -> Order : updatePaymentStatus(orderId, PAID)
activate Order
Order -> Order : finalizeBooking()
Order --> GW : OK
deactivate Order

GW --> Passenger : Payment Successful
deactivate GW
@enduml
```

---

## 5. Диаграмма компонентов (Component Diagram)

Показывает разделение системы на физические и логические компоненты (Веб-приложение, API, Микросервисы, БД).

```plantuml
@startuml
package "Client Side" {
  component [Web Application] as WebApp
  component [Mobile App] as MobApp
}

package "Server Side" {
  component [API Gateway] as Gateway
  component [Auth Service] as AuthService
  component [Booking Service] as BookingService
  component [Search Service] as SearchService
  component [Payment Service] as PaymentService
  component [Notification Service] as NotifService
}

database "PostgreSQL" as DB
database "Redis Cache" as Cache

WebApp --> Gateway : HTTPS/JSON
MobApp --> Gateway : HTTPS/JSON

Gateway --> AuthService
Gateway --> BookingService
Gateway --> SearchService

BookingService --> PaymentService
BookingService --> NotifService

BookingService ..> DB
AuthService ..> DB
SearchService ..> DB
SearchService ..> Cache
@enduml
```

---

## 6. Диаграмма пакетов (Package Diagram)

Организация исходного кода системы по слоям (Presentation, Business Logic, Data Access).

```plantuml
@startuml
package "Presentation Layer" {
  [Web Controllers]
  [Mobile API Controllers]
}

package "Business Logic Layer" {
  [Service Interfaces]
  [Service Implementations]
  [Domain Models]
}

package "Data Access Layer" {
  [Repositories]
  [Data Mappers]
  [Database Context]
}

package "Infrastructure" {
  [Email Sender]
  [Payment Gateway Client]
}

[Web Controllers] ..> [Service Interfaces]
[Mobile API Controllers] ..> [Service Interfaces]
[Service Implementations] --|> [Service Interfaces]
[Service Implementations] ..> [Domain Models]
[Service Implementations] ..> [Repositories]
[Repositories] ..> [Database Context]
[Service Implementations] ..> [Infrastructure]
@enduml
```

---

## 7. Диаграмма развертывания (Deployment Diagram)

Схема размещения программных компонентов на аппаратных узлах (Клиент, Сервер приложений, Сервер БД, Балансировщик).

```plantuml
@startuml
node "Client Device" as client {
  artifact "Web Browser" as browser
  artifact "Mobile App" as mobile
}

node "Load Balancer (Nginx)" as lb

node "Application Server" as app_server {
  component "Backend API (Golang)" as api
}

node "Database Server" as db_server {
  database "PostgreSQL" as db
}

client --> lb : HTTPS
lb --> app_server : HTTP
app_server --> db_server : TCP/5432
@enduml
```

---

## 8. Схема базы данных (ERD)

Диаграмма сущность-связь, описывающая таблицы базы данных и отношения внешних ключей.

```plantuml
@startuml
entity "User" {
  *id : number <<generated>>
  --
  *email : text
  *password_hash : text
  *role : text
  created_at : timestamp
}

entity "Passenger" {
  *id : number <<generated>>
  --
  *user_id : number <<FK>>
  *first_name : text
  *last_name : text
  passport_data : text
}

entity "Order" {
  *id : number <<generated>>
  --
  *user_id : number <<FK>>
  *created_at : timestamp
  *status : text
  total_amount : decimal
}

entity "Ticket" {
  *id : number <<generated>>
  --
  *order_id : number <<FK>>
  *seat_id : number <<FK>>
  *passenger_id : number <<FK>>
  price : decimal
  ticket_number : text
}

entity "Train" {
  *id : number <<generated>>
  --
  *number : text
  *type : text
}

entity "Carriage" {
  *id : number <<generated>>
  --
  *train_id : number <<FK>>
  *number : integer
  *type : text
}

entity "Seat" {
  *id : number <<generated>>
  --
  *carriage_id : number <<FK>>
  number : integer
}

entity "Route" {
  *id : number <<generated>>
  --
  *name : text
}

entity "RouteStation" {
  *route_id : number <<FK>>
  *station_id : number <<FK>>
  --
  arrival_time : time
  departure_time : time
  stop_order : integer
}

entity "Station" {
  *id : number <<generated>>
  --
  *name : text
  city : text
}

User ||--o{ Order
User ||--o{ Passenger
Order ||--|{ Ticket
Passenger ||--o{ Ticket
Ticket }o--|| Seat
Seat }o--|| Carriage
Carriage }o--|| Train
Train }o--|| Route
Route ||--|{ RouteStation
Station ||--o{ RouteStation
@enduml
```
