# Электронные билеты для ЖД-вокзала в Минске

> Система электронных билетов для железнодорожного вокзала в Минске  
> Курс "Проектирование человеко-машинных интерфейсов", БГУ, 4 курс

---

## Описание проекта

Комплексная система покупки электронных билетов, включающая веб-приложение, мобильное приложение и backend API. Система обеспечивает удобный интерфейс для пассажиров, позволяя быстро находить нужные рейсы, проверять наличие свободных мест и оформлять покупку билетов онлайн.

### Основная функциональность

- **Покупка билета** - оформление и оплата билетов онлайн
- **Поиск рейса** - поиск по направлению, дате, времени отправления и другим параметрам
- **Проверка свободных мест** - просмотр доступных мест в вагонах
- **Управление рейсами** - добавление новых рейсов в базу данных (для администраторов)
- **Информация о рейсе** - подробная информация включая все остановки
- **Обработка заказов** - просмотр и управление заказами пассажиров
- **Регистрация пассажиров** - создание новых учетных записей

## Структура проекта

```
pcmi
├── README.md
└── docs
    ├── lab1
    │   ├── business_processes.md
    │   ├── competitor_analysis.md
    │   ├── lab1_report.md
    │   ├── object_model.md
    │   ├── personas.md
    │   ├── user_profiles.md
    │   └── user_survey.md
    ├── lab2
    │   ├── 01_problem_statement.md
    │   ├── 02_design_strategy.md
    │   ├── 03_group_profile.md
    │   ├── 04_user_tasks_roles.md
    │   ├── 05_object_model.md
    │   ├── 06_information_architecture.md
    │   ├── 07_conceptual_mockups.md
    │   ├── 08_navigation_model.md
    │   ├── 09_cjm_impact_map.md
    │   ├── 10_interactive_storyboards.md
    │   ├── 11_design_mockups.md
    │   └── 13_execution_report.md
    └── lab3
        ├── 01_use_case.puml
        ├── 02_activity_purchase.puml
        ├── 03_activity_add_route.puml
        ├── 04_class_diagram.puml
        ├── 04_object_diagram.puml
        ├── 05_seq_search.puml
        ├── 06_seq_buy.puml
        ├── 07_seq_login.puml
        ├── 08_seq_admin_add_route.puml
        ├── 09_seq_payment.puml
        ├── 10_component.puml
        ├── 11_package.puml
        ├── 12_deployment.puml
        ├── 13_erd.puml
        ├── README.md
        ├── c4_report.md
        ├── c4model
        │   ├── 01_context.puml
        │   ├── 02_container.puml
        │   └── 03_component.puml
        ├── eventmodeling
        │   └── 01_ticket_purchase.puml
        ├── eventmodeling_report.md
        ├── eventstorming
        │   ├── 01_big_picture.puml
        │   ├── 02_process_modeling.puml
        │   └── 03_software_design.puml
        ├── eventstorming_report.md
        ├── includes
        │   ├── C4_Custom.puml
        │   ├── EventModeling.puml
        │   └── EventStorming.puml
        └── specification.md
```

---

## 🚀 Быстрый старт

### Клонирование всех репозиториев

```bash
# Основной репозиторий (документация)
git clone https://github.com/username/railway-tickets-main.git
cd railway-tickets-main

# Веб-приложение (как submodule)
git submodule add https://github.com/username/railway-tickets-web.git web

# Мобильное приложение (как submodule)
git submodule add https://github.com/username/railway-tickets-mobile.git mobile

# Backend API (как submodule)
git submodule add https://github.com/username/railway-tickets-api.git api
```

### Установка и запуск

Инструкции по установке каждой части проекта находятся в соответствующих репозиториях:
- [Веб-приложение: README](https://github.com/username/railway-tickets-web#readme)
- [Мобильное приложение: README](https://github.com/username/railway-tickets-mobile#readme)
- [Backend API: README](https://github.com/username/railway-tickets-api#readme)

---


## Авторы

Проект разработан студентами 4 курса факультета прикладной математики и информатики БГУ в рамках курса "Проектирование человеко-машинных интерфейсов".

### Распределение ролей

- **Исследование пользователей** - все участники
- **Веб-приложение** - [Имя]
- **Мобильное приложение** - [Имя]
- **Backend API** - [Имя]
- **Дизайн UI/UX** - [Имя]
- **Тестирование** - все участники

---

## Лицензия

Учебный проект. Все права защищены © 2025

---

## 🔗 Полезные ссылки

- [Методические указания ЛР №1](tasks/ПЧМИ%20ЛабРабота1%202025-2026.pdf)
- [Официальный сайт БЖД](https://poezd.rw.by)
- [Анализ конкурента: Tutu.ru](https://tutu.ru)
- [Mermaid Documentation](https://mermaid.js.org/) (для диаграмм)

---

