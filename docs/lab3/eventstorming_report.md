# Лабораторная работа №3. Задание 2: EventStorming

**Цель:** Проектирование системы "ЖД Вокзал" с использованием метода EventStorming (Исследование событий).

---

## 1. Big Picture (Крупномасштабное исследование)

На этом уровне мы исследуем предметную область, выстраивая хронологическую цепочку событий (Domain Events). Мы определяем, "что происходит" в системе, не углубляясь в детали реализации.

**Основные потоки событий:**
1.  **Администрирование:** Создание маршрутов и расписаний.
2.  **Покупка:** Поиск -> Выбор -> Бронь -> Оплата -> Билет.
3.  **Возврат:** Отмена билета -> Возврат денег.

```puml
@startuml
!define ES_EVENT_COLOR #Orange
!define ES_COMMAND_COLOR #DeepSkyBlue
!define ES_SYSTEM_COLOR #Pink
!define ES_AGGREGATE_COLOR #Yellow
!define ES_READ_MODEL_COLOR #LightGreen
!define ES_POLICY_COLOR #Plum
!define ES_ACTOR_COLOR #Yellow

skinparam defaultTextAlignment center
skinparam wrapWidth 200
skinparam maxMessageSize 150

skinparam rectangle {
    StereotypeFontSize 12
    shadowing false
}

skinparam rectangle<<DomainEvent>> {
    BackgroundColor ES_EVENT_COLOR
    BorderColor #B25000
}

skinparam rectangle<<Command>> {
    BackgroundColor ES_COMMAND_COLOR
    BorderColor #005090
}

skinparam rectangle<<System>> {
    BackgroundColor ES_SYSTEM_COLOR
    BorderColor #B03060
}

skinparam rectangle<<Aggregate>> {
    BackgroundColor ES_AGGREGATE_COLOR
    BorderColor #A08000
}

skinparam rectangle<<ReadModel>> {
    BackgroundColor ES_READ_MODEL_COLOR
    BorderColor #307020
}

skinparam rectangle<<Policy>> {
    BackgroundColor ES_POLICY_COLOR
    BorderColor #602070
}

!define DomainEvent(e_alias, e_label) rectangle "e_label" as e_alias <<DomainEvent>>
!define Command(c_alias, c_label) rectangle "c_label" as c_alias <<Command>>
!define System(s_alias, s_label) rectangle "s_label" as s_alias <<System>>
!define Aggregate(a_alias, a_label) rectangle "a_label" as a_alias <<Aggregate>>
!define ReadModel(r_alias, r_label) rectangle "r_label" as r_alias <<ReadModel>>
!define Policy(p_alias, p_label) rectangle "p_label" as p_alias <<Policy>>
!define Actor(a_alias, a_label) actor "a_label" as a_alias

hide stereo

title EventStorming: Big Picture

' Admin Flow
DomainEvent(RouteDefined, "Маршрут определен")
DomainEvent(TrainScheduled, "Поезд назначен в расписание")
DomainEvent(SeatsGenerated, "Места сгенерированы")

RouteDefined --> TrainScheduled
TrainScheduled --> SeatsGenerated

' User Registration Flow
DomainEvent(UserRegistered, "Пользователь зарегистрирован")

' Purchasing Flow
DomainEvent(SearchRequested, "Выполнен поиск рейсов")
DomainEvent(SeatSelected, "Место выбрано")
DomainEvent(OrderCreated, "Заказ создан (Pending)")
DomainEvent(PaymentInitiated, "Оплата инициирована")
DomainEvent(PaymentSucceeded, "Оплата прошла успешно")
DomainEvent(PaymentFailed, "Оплата отклонена")
DomainEvent(TicketIssued, "Билет выпущен")
DomainEvent(EmailSent, "Письмо с билетом отправлено")

SeatsGenerated --> SearchRequested
SearchRequested --> SeatSelected
SeatSelected --> OrderCreated
OrderCreated --> PaymentInitiated

PaymentInitiated --> PaymentSucceeded
PaymentInitiated --> PaymentFailed

PaymentSucceeded --> TicketIssued
TicketIssued --> EmailSent

' Refund Flow
DomainEvent(RefundRequested, "Запрошен возврат")
DomainEvent(TicketCancelled, "Билет аннулирован")
DomainEvent(MoneyReturned, "Средства возвращены")

TicketIssued --> RefundRequested
RefundRequested --> TicketCancelled
TicketCancelled --> MoneyReturned

@enduml
```

---

## 2. Process Modeling (Моделирование процесса)

На этом этапе мы детализируем бизнес-процессы, добавляя:
*   **Команды (Commands):** Действия, инициируемые пользователем или системой.
*   **Акторы (Actors):** Кто выполняет команды.
*   **Системы (Systems):** Внешние сервисы или внутренние модули.
*   **Политики (Policies):** Бизнес-правила (реакция на события).
*   **Модели чтения (Read Models):** Данные, необходимые для принятия решений.

**Ключевой процесс: Покупка билета**

```puml
@startuml
!define ES_EVENT_COLOR #Orange
!define ES_COMMAND_COLOR #DeepSkyBlue
!define ES_SYSTEM_COLOR #Pink
!define ES_AGGREGATE_COLOR #Yellow
!define ES_READ_MODEL_COLOR #LightGreen
!define ES_POLICY_COLOR #Plum
!define ES_ACTOR_COLOR #Yellow

skinparam defaultTextAlignment center
skinparam wrapWidth 200
skinparam maxMessageSize 150

skinparam rectangle {
    StereotypeFontSize 12
    shadowing false
}

skinparam rectangle<<DomainEvent>> {
    BackgroundColor ES_EVENT_COLOR
    BorderColor #B25000
}

skinparam rectangle<<Command>> {
    BackgroundColor ES_COMMAND_COLOR
    BorderColor #005090
}

skinparam rectangle<<System>> {
    BackgroundColor ES_SYSTEM_COLOR
    BorderColor #B03060
}

skinparam rectangle<<Aggregate>> {
    BackgroundColor ES_AGGREGATE_COLOR
    BorderColor #A08000
}

skinparam rectangle<<ReadModel>> {
    BackgroundColor ES_READ_MODEL_COLOR
    BorderColor #307020
}

skinparam rectangle<<Policy>> {
    BackgroundColor ES_POLICY_COLOR
    BorderColor #602070
}

!define DomainEvent(e_alias, e_label) rectangle "e_label" as e_alias <<DomainEvent>>
!define Command(c_alias, c_label) rectangle "c_label" as c_alias <<Command>>
!define System(s_alias, s_label) rectangle "s_label" as s_alias <<System>>
!define Aggregate(a_alias, a_label) rectangle "a_label" as a_alias <<Aggregate>>
!define ReadModel(r_alias, r_label) rectangle "r_label" as r_alias <<ReadModel>>
!define Policy(p_alias, p_label) rectangle "p_label" as p_alias <<Policy>>
!define Actor(a_alias, a_label) actor "a_label" as a_alias

hide stereo

title EventStorming: Process Modeling (Покупка билета)

' Actors
Actor(Passenger, "Пассажир")

' Commands and Events flow

' --- Search Phase ---
Command(SearchTrains, "Поиск поездов")
System(SearchEngine, "Поисковый движок")
DomainEvent(TrainsFound, "Поезда найдены")
ReadModel(TrainSchedule, "Расписание и цены")

Passenger --> SearchTrains
SearchTrains --> SearchEngine
SearchEngine --> TrainsFound
TrainsFound ..> TrainSchedule : updates view

' --- Selection Phase ---
Command(SelectSeat, "Выбрать место")
Aggregate(BookingInfo, "Бронирование")
DomainEvent(SeatLocked, "Место временно заблокировано")
Policy(SeatLockTimer, "Таймер блокировки (15 мин)")

Passenger --> SelectSeat
SelectSeat --> BookingInfo
BookingInfo --> SeatLocked
SeatLocked --> SeatLockTimer

' --- Order Phase ---
Command(CreateOrder, "Оформить заказ")
Aggregate(Order, "Заказ")
DomainEvent(OrderCreated, "Заказ создан")

Passenger --> CreateOrder
CreateOrder --> Order
Order --> OrderCreated

' --- Payment Phase ---
Command(PayForOrder, "Оплатить заказ")
System(PaymentGateway, "Банковский шлюз")
DomainEvent(PaymentAuthorized, "Оплата авторизована")
DomainEvent(PaymentDeclined, "Оплата отклонена")

Passenger --> PayForOrder
PayForOrder --> PaymentGateway
PaymentGateway --> PaymentAuthorized
PaymentGateway --> PaymentDeclined

' --- Fulfillment Phase ---
Policy(IssueTicketPolicy, "При успешной оплате -> Выпустить билет")
Command(GenerateTicket, "Сгенерировать билет")
Aggregate(TicketAgg, "Билет")
DomainEvent(TicketGenerated, "Билет сгенерирован")
System(EmailService, "Почтовый сервис")
DomainEvent(EmailSent, "Email отправлен")

PaymentAuthorized --> IssueTicketPolicy
IssueTicketPolicy --> GenerateTicket
GenerateTicket --> TicketAgg
TicketAgg --> TicketGenerated
TicketGenerated --> EmailService
EmailService --> EmailSent
@enduml
```

---

## 3. Software Design (Проектирование архитектуры)

Группировка агрегатов и событий в Ограниченные Контексты (Bounded Contexts) для построения микросервисной архитектуры.

**Выделенные контексты:**
1.  **Catalog Context:** Управление расписанием, поездами, маршрутами.
2.  **Booking Context:** Управление заказами, резервация мест.
3.  **Identity Context:** Пользователи, профили пассажиров.
4.  **Payment Context:** Обработка транзакций.
5.  **Notification Context:** Рассылка уведомлений.

```puml
@startuml
!define ES_EVENT_COLOR #Orange
!define ES_COMMAND_COLOR #DeepSkyBlue
!define ES_SYSTEM_COLOR #Pink
!define ES_AGGREGATE_COLOR #Yellow
!define ES_READ_MODEL_COLOR #LightGreen
!define ES_POLICY_COLOR #Plum
!define ES_ACTOR_COLOR #Yellow

skinparam defaultTextAlignment center
skinparam wrapWidth 200
skinparam maxMessageSize 150

skinparam rectangle {
    StereotypeFontSize 12
    shadowing false
}

skinparam rectangle<<DomainEvent>> {
    BackgroundColor ES_EVENT_COLOR
    BorderColor #B25000
}

skinparam rectangle<<Command>> {
    BackgroundColor ES_COMMAND_COLOR
    BorderColor #005090
}

skinparam rectangle<<System>> {
    BackgroundColor ES_SYSTEM_COLOR
    BorderColor #B03060
}

skinparam rectangle<<Aggregate>> {
    BackgroundColor ES_AGGREGATE_COLOR
    BorderColor #A08000
}

skinparam rectangle<<ReadModel>> {
    BackgroundColor ES_READ_MODEL_COLOR
    BorderColor #307020
}

skinparam rectangle<<Policy>> {
    BackgroundColor ES_POLICY_COLOR
    BorderColor #602070
}

!define DomainEvent(e_alias, e_label) rectangle "e_label" as e_alias <<DomainEvent>>
!define Command(c_alias, c_label) rectangle "c_label" as c_alias <<Command>>
!define System(s_alias, s_label) rectangle "s_label" as s_alias <<System>>
!define Aggregate(a_alias, a_label) rectangle "a_label" as a_alias <<Aggregate>>
!define ReadModel(r_alias, r_label) rectangle "r_label" as r_alias <<ReadModel>>
!define Policy(p_alias, p_label) rectangle "p_label" as p_alias <<Policy>>
!define Actor(a_alias, a_label) actor "a_label" as a_alias

hide stereo

title Software Design (Aggregates & Bounded Contexts)

rectangle "Catalog Context" #line.dashed {
    Aggregate(Route, "Маршрут")
    Aggregate(Train, "Поезд")
    DomainEvent(RouteCreated, "Маршрут создан")
    DomainEvent(TrainAdded, "Поезд добавлен")
    
    Route --> RouteCreated
    Train --> TrainAdded
}

rectangle "Booking Context" #line.dashed {
    Aggregate(Order, "Заказ")
    Aggregate(SeatInventory, "Инвентарь мест")
    
    Command(BookSeat, "Забронировать")
    DomainEvent(SeatReserved, "Место занято")
    DomainEvent(OrderConfirmed, "Заказ подтвержден")
    
    BookSeat --> Order
    Order --> OrderConfirmed
    OrderConfirmed --> SeatInventory
    SeatInventory --> SeatReserved
}

rectangle "Identity Context" #line.dashed {
    Aggregate(User, "Пользователь")
    Aggregate(PassengerProfile, "Профиль пассажира")
    
    Command(Register, "Регистрация")
    DomainEvent(UserCreated, "Пользователь создан")
    
    Register --> User
    User --> UserCreated
}

rectangle "Payment Context" #line.dashed {
    Aggregate(Payment, "Платеж")
    Command(ProcessPayment, "Провести оплату")
    DomainEvent(Paid, "Оплачено")
    
    ProcessPayment --> Payment
    Payment --> Paid
}

rectangle "Notification Context" #line.dashed {
    Aggregate(Notification, "Уведомление")
    DomainEvent(Sent, "Отправлено")
}

' Relationships
UserCreated ..> Order : "Используется при заказе"
SeatReserved ..> Payment : "Инициирует оплату"
Paid ..> OrderConfirmed : "Обновляет статус"
OrderConfirmed ..> Notification : "Триггерит письмо"
@enduml
```

