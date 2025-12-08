# Лабораторная работа №4. Задание 2: Проектирование физической модели базы данных

## 1. Логическая модель базы данных

Уточненная логическая структура данных системы.

| Сущность (Entity) | Таблица БД (Table) | Поле (Field) | Смысл поля (Description) | Тип данных (Logical Type) |
| :--- | :--- | :--- | :--- | :--- |
| **User** | `users` | `id` | Уникальный идентификатор пользователя | Integer |
| | | `email` | Электронная почта (логин) | String |
| | | `password_hash` | Хэш пароля | String |
| | | `role` | Роль пользователя (Passenger, Admin) | Enum/String |
| | | `created_at` | Дата регистрации | Timestamp |
| **Passenger** | `passengers` | `id` | Идентификатор профиля пассажира | Integer |
| | | `user_id` | Ссылка на аккаунт пользователя | Integer (FK) |
| | | `first_name` | Имя | String |
| | | `last_name` | Фамилия | String |
| | | `passport_data` | Паспортные данные | String |
| **Order** | `orders` | `id` | Уникальный номер заказа | Integer |
| | | `user_id` | Пользователь, оформивший заказ | Integer (FK) |
| | | `status` | Статус (Оплачен, Отменен) | String |
| | | `total_amount` | Общая сумма заказа | Decimal |
| **Ticket** | `tickets` | `id` | Уникальный номер билета | Integer |
| | | `order_id` | Ссылка на заказ | Integer (FK) |
| | | `seat_id` | Ссылка на конкретное место | Integer (FK) |
| | | `ticket_number` | Визуальный номер билета | String |
| | | `departure_date` | Дата отправления по билету | Date |
| **Train** | `trains` | `id` | Идентификатор поезда | Integer |
| | | `number` | Номер поезда (напр. 703Б) | String |
| | | `type` | Тип поезда (Скоростной, Региональный) | String |
| **Carriage** | `carriages` | `id` | Идентификатор вагона | Integer |
| | | `train_id` | Принадлежность к поезду | Integer (FK) |
| | | `number` | Порядковый номер вагона | Integer |
| **Seat** | `seats` | `id` | Идентификатор места | Integer |
| | | `carriage_id` | Вагон | Integer (FK) |
| | | `number` | Номер места | Integer |
| **Route** | `routes` | `id` | Идентификатор маршрута | Integer |
| | | `name` | Название маршрута | String |
| **Station** | `stations` | `id` | Идентификатор станции | Integer |
| | | `name` | Название станции | String |
| | | `city` | Город расположения | String |

---

## 2. Физическая модель данных (ER Diagram)

Физическая модель спроектирована с учетом СУБД **PostgreSQL**.

![Physical ER Diagram](http://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.githubusercontent.com/qre/project13-stealthisproject/docs/docs/lab4/03_physical_erd.puml)

*Исходный код диаграммы: [03_physical_erd.puml](./03_physical_erd.puml)*

### SQL Схема

Для создания структуры базы данных разработан SQL-скрипт (DDL).

[Скачать файл schema.sql](./schema.sql)

```sql
-- Пример создания таблицы Users
CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL DEFAULT 'PASSENGER',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
-- ... (полный код в файле schema.sql)
```

