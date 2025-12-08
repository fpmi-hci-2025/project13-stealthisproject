-- PostgreSQL Database Schema for Railway Ticket System

-- Enable UUID extension if needed (optional, using BIGSERIAL for simplicity as per diagram)
-- CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 1. Users Table
CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL DEFAULT 'PASSENGER', -- e.g., 'ADMIN', 'PASSENGER'
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 2. Passengers Table
CREATE TABLE passengers (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT REFERENCES users(id) ON DELETE CASCADE,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    passport_data VARCHAR(50)
);

-- 3. Orders Table
CREATE TABLE orders (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT REFERENCES users(id) ON DELETE SET NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) NOT NULL DEFAULT 'PENDING', -- 'PAID', 'CANCELLED'
    total_amount DECIMAL(10, 2) NOT NULL DEFAULT 0.00
);

-- 4. Trains Table
CREATE TABLE trains (
    id BIGSERIAL PRIMARY KEY,
    number VARCHAR(20) NOT NULL UNIQUE,
    type VARCHAR(50) -- 'INTERCITY', 'REGIONAL'
);

-- 5. Carriages Table
CREATE TABLE carriages (
    id BIGSERIAL PRIMARY KEY,
    train_id BIGINT REFERENCES trains(id) ON DELETE CASCADE,
    number INTEGER NOT NULL,
    type VARCHAR(50) -- 'COUPE', 'PLATZCART', 'LUX'
);

-- 6. Seats Table
CREATE TABLE seats (
    id BIGSERIAL PRIMARY KEY,
    carriage_id BIGINT REFERENCES carriages(id) ON DELETE CASCADE,
    number INTEGER NOT NULL
);

-- 7. Routes Table
CREATE TABLE routes (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    train_id BIGINT REFERENCES trains(id) ON DELETE SET NULL
);

-- 8. Stations Table
CREATE TABLE stations (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL
);

-- 9. Route Stations (Join Table for Many-to-Many relationship with additional data)
CREATE TABLE route_stations (
    route_id BIGINT REFERENCES routes(id) ON DELETE CASCADE,
    station_id BIGINT REFERENCES stations(id) ON DELETE CASCADE,
    arrival_time TIME,
    departure_time TIME,
    stop_order INTEGER NOT NULL,
    PRIMARY KEY (route_id, station_id)
);

-- 10. Tickets Table
CREATE TABLE tickets (
    id BIGSERIAL PRIMARY KEY,
    order_id BIGINT REFERENCES orders(id) ON DELETE CASCADE,
    seat_id BIGINT REFERENCES seats(id), -- Nullable if generic ticket, but usually required
    passenger_id BIGINT REFERENCES passengers(id) ON DELETE SET NULL,
    departure_date DATE NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    ticket_number VARCHAR(50) NOT NULL UNIQUE,
    status VARCHAR(50) NOT NULL DEFAULT 'ACTIVE' -- 'USED', 'REFUNDED'
);

-- Indexes for performance
CREATE INDEX idx_tickets_order_id ON tickets(order_id);
CREATE INDEX idx_tickets_passenger_id ON tickets(passenger_id);
CREATE INDEX idx_route_stations_route_id ON route_stations(route_id);

