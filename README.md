# NourishNet: AI-Based Surplus Food Waste Redistribution System

[![Spring Boot 3.3](https://img.shields.io/badge/Spring_Boot-3.3-emerald)](https://spring.io/projects/spring-boot)
[![React 19](https://img.shields.io/badge/React-19-cyan)](https://react.dev)
[![Java 21](https://img.shields.io/badge/Java-21-orange)](https://www.oracle.com/java/)
[![Tailwind CSS v4](https://img.shields.io/badge/Tailwind_CSS-v4-blue)](https://tailwindcss.com)
[![Google Gemini 2.5 AI](https://img.shields.io/badge/Gemini_AI-2.5-teal)](https://ai.google.dev)

NourishNet is a full-stack, AI-powered platform designed to eliminate urban food waste by connecting hotels, restaurants, bakeries, and event caterers with verified local NGOs, food banks, and volunteer logistics fleets in real time.

---

## 🌟 Key Features

1. **Surplus Food Posting Portal:** Donors list excess food with quantity, category, storage conditions, and pickup location.
2. **Google Gemini AI Freshness Engine:** Calculates food safety windows and freshness scores based on preparation time, category, and temperature.
3. **NGO Claim & Dispatch Hub:** Verified NGOs browse available donations and claim listings with instant volunteer dispatch and OTP pickup verification.
4. **Real-time Notifications:** Instant alerts for AI match recommendations, pickup status changes, and freshness warnings.
5. **System Overseer Admin Console:** Approve NGO verifications, moderate food listings, manage user accounts, and generate system audit reports.
6. **Sustainability & Impact Analytics:** Track total food waste diverted (Kg), meals served, CO2 equivalent greenhouse gas savings, and methane avoidance.

---

## 📁 Project Folder Structure

```
nourishnet-food-redistribution/
├── backend/                             # Spring Boot 3.3 / Java 21 REST API Project
│   ├── pom.xml                          # Maven build configuration & dependencies
│   └── src/
│       ├── main/
│       │   ├── java/com/nourishnet/
│       │   │   ├── config/              # Security & CORS configuration
│       │   │   ├── controller/          # REST API Controllers (Auth, Food, Requests, Admin, Analytics)
│       │   │   ├── model/               # JPA Entity models (User, FoodDonation, Request, Notification)
│       │   │   ├── repository/         # Spring Data JPA repositories
│       │   │   ├── service/            # Business logic & Google Gemini AI service
│       │   │   └── NourishNetApp.java   # Spring Boot Application entrypoint
│       │   └── resources/
│       │       └── application.yml      # DB credentials, server port, JWT config
│       └── test/                        # JUnit 5 & Mockito test cases
├── src/                                 # React 19 Frontend Application
│   ├── components/                      # Reusable UI components (Navbar, Footer, ProtectedRoute)
│   ├── context/                         # Auth Context provider
│   ├── hooks/                           # Custom React hooks (useAuth)
│   ├── pages/                           # Main Application Views
│   │   ├── HomePage.jsx                 # Landing page & quick hero actions
│   │   ├── LoginPage.jsx                # Secure user login
│   │   ├── RegisterPage.jsx             # Role-based account creation
│   │   ├── DonorDashboard.jsx           # Donor food management portal
│   │   ├── DonateFoodPage.jsx           # Surplus food creation form with AI rating
│   │   ├── NGODashboard.jsx             # NGO available food claim hub
│   │   ├── AdminDashboard.jsx           # Admin user verification & moderation
│   │   ├── AnalyticsPage.jsx            # Impact metrics & CO2 savings
│   │   ├── NotificationsPage.jsx        # Real-time alert feed
│   │   ├── ProfilePage.jsx              # User account settings
│   │   └── DonationHistoryPage.jsx      # Historical transaction audit log
│   ├── services/                        # Axios REST API services layer
│   ├── App.tsx                          # React Router routes configuration
│   └── main.tsx                         # React entrypoint
├── .env.example                         # Environment variable definitions
├── schema.sql                           # Complete Database DDL script & sample seed data
├── postman_collection.json              # Postman collection JSON for REST API testing
├── API_DOCUMENTATION.md                 # Detailed REST API endpoint specification
└── README.md                            # Complete setup & deployment guide
```

---

## 🚀 Project Setup Guide

### 1. Prerequisites
- **Java Development Kit (JDK 21+)** installed
- **Apache Maven 3.8+** installed
- **Node.js v20+** & npm installed
- **MySQL 8.0+ / PostgreSQL 15+** server running

### 2. Database Initialization
Execute the provided SQL script to provision the schema and seed data:
```bash
mysql -u root -p < schema.sql
```

### 3. Backend Setup (Spring Boot)
1. Navigate to the backend directory:
   ```bash
   cd backend
   ```
2. Update database credentials in `src/main/resources/application.yml`.
3. Build and run the Spring Boot application:
   ```bash
   mvn clean spring-boot:run
   ```
   *The backend REST API server will run on `http://localhost:8080` (or proxied on port 3000).*

### 4. Frontend Setup (React 19 + Vite)
1. Install dependencies from the root directory:
   ```bash
   npm install
   ```
2. Launch the frontend development server:
   ```bash
   npm run dev
   ```
3. Access the web application at `http://localhost:3000`.

---

## 🧪 Testing Guide

### Backend Testing (JUnit 5 & Mockito)
Run the backend unit and integration test suite:
```bash
cd backend
mvn test
```

### Frontend Verification
Run the TypeScript type checker and linter:
```bash
npm run lint
```

---

## 📬 Postman API Collection

Import `postman_collection.json` directly into Postman to test all Spring Boot endpoints:
- `POST /api/v1/auth/register` - Create account
- `POST /api/v1/auth/login` - Authenticate user
- `GET /api/v1/donations` - List all surplus food listings
- `GET /api/v1/donations/available` - Filter active food for NGOs
- `POST /api/v1/donations` - Publish surplus food listing
- `POST /api/v1/requests` - Claim food donation
- `GET /api/v1/analytics/metrics` - Fetch impact statistics

---

## 🌐 Deployment Guide

### Docker Deployment
```dockerfile
# Dockerfile for Backend
FROM eclipse-temurin:21-jdk-alpine AS build
WORKDIR /app
COPY backend/ .
RUN ./mvnw clean package -DskipTests

FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
```

Build and run Docker container:
```bash
docker build -t nourishnet-backend .
docker run -p 8080:8080 nourishnet-backend
```

---

## 📄 License
This project is open source and available under the [MIT License](LICENSE).
