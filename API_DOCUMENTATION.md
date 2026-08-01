# NourishNet REST API Documentation

**Version:** 1.0.0  
**Base URL:** `http://localhost:3000/api/v1`  
**Format:** JSON  

---

## 1. Authentication Endpoints

### 1.1 Register User
- **Method:** `POST`
- **Endpoint:** `/api/v1/auth/register`
- **Request Body:**
```json
{
  "fullName": "Anish Kumar",
  "email": "anish@example.com",
  "password": "Password123",
  "phone": "+91 98765 43210",
  "role": "DONOR",
  "organizationName": "Grand Palace Hotel",
  "city": "Bangalore"
}
```
- **Response (200 OK):**
```json
{
  "id": 1,
  "fullName": "Anish Kumar",
  "email": "anish@example.com",
  "role": "DONOR",
  "city": "Bangalore",
  "token": "mock-jwt-token-xyz"
}
```

### 1.2 User Login
- **Method:** `POST`
- **Endpoint:** `/api/v1/auth/login`
- **Request Body:**
```json
{
  "email": "donor.hotel@nourishnet.org",
  "password": "password123"
}
```
- **Response (200 OK):**
```json
{
  "id": 1,
  "fullName": "Grand Palace Hotel",
  "email": "donor.hotel@nourishnet.org",
  "role": "DONOR",
  "token": "mock-jwt-token-12345"
}
```

---

## 2. Food Donation Endpoints

### 2.1 Get All Donations
- **Method:** `GET`
- **Endpoint:** `/api/v1/donations`
- **Response (200 OK):**
```json
[
  {
    "id": 1,
    "title": "Banquet Surplus - Paneer Butter Masala",
    "category": "Cooked Meals",
    "quantityKg": 25.0,
    "servings": 80,
    "freshnessScore": 96,
    "status": "AVAILABLE",
    "pickupAddress": "Grand Palace Gate 2, Ring Road, Bangalore"
  }
]
```

### 2.2 Post Surplus Food Donation
- **Method:** `POST`
- **Endpoint:** `/api/v1/donations`
- **Request Body:**
```json
{
  "title": "Fresh Artisan Bakery Breads",
  "category": "Bakery & Snacks",
  "quantityKg": 15.0,
  "servings": 50,
  "freshnessScore": 92,
  "storageCondition": "Room Temperature",
  "pickupAddress": "Indiranagar 100ft Road, Bangalore",
  "donorName": "Le Petit Bakery"
}
```
- **Response (201 Created):**
```json
{
  "id": 2,
  "title": "Fresh Artisan Bakery Breads",
  "status": "AVAILABLE",
  "message": "Food donation published successfully."
}
```

---

## 3. Food Request & Claim Endpoints

### 3.1 Claim Food Donation (NGO)
- **Method:** `POST`
- **Endpoint:** `/api/v1/requests`
- **Request Body:**
```json
{
  "donationId": 1,
  "donationTitle": "Banquet Surplus",
  "ngoName": "Feeding India Foundation",
  "beneficiariesCount": 80,
  "urgency": "HIGH"
}
```
- **Response (200 OK):**
```json
{
  "id": 1,
  "donationId": 1,
  "status": "CLAIMED",
  "pickupOtp": "8492",
  "message": "Donation claimed successfully. Volunteer dispatched."
}
```

---

## 4. Analytics & Impact Metrics

### 4.1 Get Sustainability Metrics
- **Method:** `GET`
- **Endpoint:** `/api/v1/analytics/metrics`
- **Response (200 OK):**
```json
{
  "foodSavedKg": 1420.5,
  "mealsServed": 4260,
  "co2SavedKg": 3551.2,
  "activeNgos": 48
}
```
