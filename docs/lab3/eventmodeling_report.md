# Лабораторная работа №3. Задание 3: Event Modeling

**Цель:** Проектирование системы "ЖД Вокзал" с использованием метода Event Modeling.

Этот метод фокусируется на том, как информация изменяется во времени через события, связывая интерфейс (Views), действия пользователя (Commands) и системные события (Events).

---

## Описание модели

Диаграмма описывает сквозной процесс покупки билета, показывая взаимодействие между:
*   **Пассажиром** (пользователем)
*   **Интерфейсом** (UI/Views)
*   **Бэкендом** (Commands & Events)
*   **Внешней системой** (Платежный шлюз)

### Легенда
*   **View (Зеленый):** То, что видит пользователь (Экран, Форма).
*   **Command (Синий):** Действие, меняющее состояние системы (Нажатие кнопки, API запрос).
*   **Event (Оранжевый):** Фактическое событие, произошедшее в системе (Состояние изменилось).

---

## Диаграмма: Покупка билета

```puml
@startuml
' --- Event Modeling Notation via Activity Diagram ---
!define EM_EVENT_COLOR #Orange
!define EM_COMMAND_COLOR #DeepSkyBlue
!define EM_VIEW_COLOR #LightGreen
!define EM_ACTOR_COLOR #Yellow
!define EM_SYSTEM_COLOR #Pink

skinparam defaultTextAlignment center
skinparam wrapWidth 200
skinparam maxMessageSize 150

' Use Activity nodes with custom styles
skinparam activity {
    BackgroundColor EM_EVENT_COLOR
    BorderColor #B25000
    FontSize 12
}

' Define macros for Activity Diagram syntax
!define Event(label) #Orange:label;
!define Command(label) #DeepSkyBlue:label;
!define View(label) #LightGreen:label;

title Event Modeling: Система продажи ЖД билетов

' Swimlanes (Actors / Systems)
|#AntiqueWhite|Пассажир|
|#LightBlue|Интерфейс (UI)|
|#LightYellow|Backend (API)|
|#Lavender|Платежная система|

' --- Scenario: Search & View ---

|Пассажир|
start
:Открывает сайт;

|Интерфейс (UI)|
View("Форма поиска")

|Пассажир|
:Вводит параметры\n(Минск -> Гомель, 12.12);
:Нажимает "Найти";

|Backend (API)|
Command("Поиск рейсов")
Event("Поезда найдены")

|Интерфейс (UI)|
View("Список поездов")

' --- Scenario: Booking ---

|Пассажир|
:Выбирает поезд;

|Backend (API)|
Event("Поезд выбран")

|Интерфейс (UI)|
View("Схема вагона")

|Пассажир|
:Выбирает место 12;
:Нажимает "Купить";

|Backend (API)|
Command("Создать заказ")
Event("Заказ создан\n(Status: Pending)")
Event("Место 12 заблокировано")

' --- Scenario: Payment ---

|Интерфейс (UI)|
View("Форма оплаты")

|Пассажир|
:Вводит данные карты;
:Нажимает "Оплатить";

|Платежная система|
Command("Обработать платеж")
Event("Оплата авторизована")

|Backend (API)|
Event("Платеж подтвержден")
Event("Билет выпущен")
Event("Письмо отправлено")

|Интерфейс (UI)|
View("Билет и подтверждение")

stop
@enduml
```
