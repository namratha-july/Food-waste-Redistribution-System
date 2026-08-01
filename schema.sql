-- =============================================================================
-- NOURISHNET: AI-BASED SURPLUS FOOD REDISTRIBUTION SYSTEM
-- DATABASE DDL & SAMPLE SEED DATA SCRIPT (MySQL / MariaDB / PostgreSQL Compatible)
-- =============================================================================

CREATE DATABASE IF NOT EXISTS nourishnet_db;
USE nourishnet_db;

-- 1. USERS TABLE
CREATE TABLE IF NOT EXISTS users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    phone VARCHAR(30) NOT NULL,
    role VARCHAR(30) NOT NULL DEFAULT 'DONOR', -- 'DONOR', 'NGO', 'VOLUNTEER', 'ADMIN'
    organization_name VARCHAR(200),
    registration_number VARCHAR(100),
    city VARCHAR(100) DEFAULT 'Bangalore',
    is_verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 2. FOOD DONATIONS TABLE
CREATE TABLE IF NOT EXISTS food_donations (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    category VARCHAR(80) NOT NULL, -- 'Cooked Meals', 'Bakery & Snacks', 'Fresh Produce', 'Dairy & Beverages'
    quantity_kg DECIMAL(10, 2) NOT NULL,
    servings INT NOT NULL,
    freshness_score INT DEFAULT 95, -- 0 to 100 AI Freshness Score
    storage_condition VARCHAR(100) DEFAULT 'Refrigerated Container',
    pickup_address TEXT NOT NULL,
    donor_id BIGINT NOT NULL,
    donor_name VARCHAR(150),
    claimed_by_ngo VARCHAR(150),
    pickup_otp VARCHAR(10),
    status VARCHAR(50) DEFAULT 'AVAILABLE', -- 'AVAILABLE', 'CLAIMED', 'IN_TRANSIT', 'DELIVERED', 'EXPIRED'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (donor_id) REFERENCES users(id) ON DELETE CASCADE
);

-- 3. FOOD REQUESTS TABLE
CREATE TABLE IF NOT EXISTS food_requests (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    donation_id BIGINT NOT NULL,
    donation_title VARCHAR(255) NOT NULL,
    ngo_id BIGINT,
    ngo_name VARCHAR(150) NOT NULL,
    beneficiaries_count INT DEFAULT 50,
    urgency VARCHAR(30) DEFAULT 'HIGH', -- 'LOW', 'MEDIUM', 'HIGH', 'CRITICAL'
    status VARCHAR(50) DEFAULT 'PENDING', -- 'PENDING', 'ACCEPTED', 'FULFILLED', 'REJECTED'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (donation_id) REFERENCES food_donations(id) ON DELETE CASCADE
);

-- 4. NOTIFICATIONS TABLE
CREATE TABLE IF NOT EXISTS notifications (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT,
    title VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    type VARCHAR(30) DEFAULT 'INFO', -- 'SUCCESS', 'INFO', 'WARNING', 'ALERT'
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 5. ANALYTICS METRICS TABLE
CREATE TABLE IF NOT EXISTS analytics_logs (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    metric_key VARCHAR(100) NOT NULL UNIQUE,
    metric_value DECIMAL(12, 2) NOT NULL,
    unit VARCHAR(30) NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- =============================================================================
-- SAMPLE SEED DATA
-- =============================================================================

-- Seed Users
INSERT INTO users (id, full_name, email, password_hash, phone, role, organization_name, registration_number, city, is_verified)
VALUES 
(1, 'Grand Palace Hotel', 'donor.hotel@nourishnet.org', '$2a$10$wT8q6N4LgV9pM1kR3qW8e.1a2b3c4d5e6f7g8h9i0j', '+91 98765 43210', 'DONOR', 'Grand Palace Banquet & Hotel', 'REST-88392', 'Bangalore', TRUE),
(2, 'Feeding India Foundation', 'ngo.feeding@nourishnet.org', '$2a$10$wT8q6N4LgV9pM1kR3qW8e.1a2b3c4d5e6f7g8h9i0j', '+91 98123 45678', 'NGO', 'Feeding India Trust', 'NGO-REG-2026-X89', 'Bangalore', TRUE),
(3, 'Rohan Sharma', 'volunteer.rohan@nourishnet.org', '$2a$10$wT8q6N4LgV9pM1kR3qW8e.1a2b3c4d5e6f7g8h9i0j', '+91 97777 88888', 'VOLUNTEER', 'NourishNet Logistics Corps', 'VOL-771', 'Bangalore', TRUE),
(4, 'System Administrator', 'admin@nourishnet.org', '$2a$10$wT8q6N4LgV9pM1kR3qW8e.1a2b3c4d5e6f7g8h9i0j', '+91 90000 11111', 'ADMIN', 'NourishNet HQ', 'ADM-001', 'Bangalore', TRUE)
ON DUPLICATE KEY UPDATE id=id;

-- Seed Food Donations
INSERT INTO food_donations (id, title, category, quantity_kg, servings, freshness_score, storage_condition, pickup_address, donor_id, donor_name, claimed_by_ngo, pickup_otp, status)
VALUES 
(1, 'Banquet Dinner Surplus - Paneer Masala, Veg Biryani & Naan', 'Cooked Meals', 25.00, 80, 96, 'Refrigerated Container', 'Grand Palace Banquet Hall, Gate 2, Outer Ring Road, Bangalore', 1, 'Grand Palace Hotel', NULL, NULL, 'AVAILABLE'),
(2, 'Fresh Assorted Artisan Bakery Breads & Croissants', 'Bakery & Snacks', 12.50, 45, 92, 'Room Temperature', 'Le Petit Bakery, Indiranagar 100ft Road, Bangalore', 1, 'Le Petit Bakery', 'Feeding India Foundation', '8492', 'CLAIMED'),
(3, 'Fresh Organic Vegetables & Hydroponic Greens', 'Fresh Produce', 35.00, 110, 98, 'Cold Chilled Storage', 'Metro Supermarket Food Depot, Koramangala, Bangalore', 1, 'Metro Supermarket', 'Robin Hood Army NGO', '1934', 'DELIVERED')
ON DUPLICATE KEY UPDATE id=id;

-- Seed Food Requests
INSERT INTO food_requests (id, donation_id, donation_title, ngo_id, ngo_name, beneficiaries_count, urgency, status)
VALUES 
(1, 2, 'Fresh Assorted Artisan Bakery Breads & Croissants', 2, 'Feeding India Foundation', 45, 'HIGH', 'ACCEPTED')
ON DUPLICATE KEY UPDATE id=id;

-- Seed Notifications
INSERT INTO notifications (id, user_id, title, message, type, is_read)
VALUES 
(1, 1, 'AI Match Dispatch Alert', 'Google Gemini AI matched your donation "Banquet Surplus" to 3 nearby NGOs in 2.4km radius.', 'SUCCESS', FALSE),
(2, 2, 'New Available Surplus Nearby', 'Grand Palace Hotel posted 25.0 Kg Cooked Meals. Freshness Score: 96%. Claim now.', 'INFO', FALSE),
(3, 3, 'Volunteer Route Assigned', 'Pick up order #DON-2 assigned to indiranagar route. Pickup OTP generated.', 'INFO', TRUE)
ON DUPLICATE KEY UPDATE id=id;

-- Seed Analytics Initial Logs
INSERT INTO analytics_logs (metric_key, metric_value, unit)
VALUES 
('food_saved_kg', 1420.50, 'Kg'),
('meals_served', 4260.00, 'Meals'),
('co2_saved_kg', 3551.20, 'Kg'),
('active_ngos', 48.00, 'Organizations')
ON DUPLICATE KEY UPDATE metric_value=VALUES(metric_value);
