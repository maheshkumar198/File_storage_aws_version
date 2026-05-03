# 🚀 Cloud File Storage System (AWS + DevOps)

A production-style cloud-based file storage system built using AWS and modern DevOps practices.
This project demonstrates secure file handling, CDN delivery, containerized deployment, and real-world infrastructure design.

---

## 🧱 Architecture Overview

Frontend (React) is served via CloudFront CDN from a private S3 bucket (OAC enabled).
Backend runs on EC2 behind NGINX reverse proxy with HTTPS.
Files are stored in private S3 and accessed securely via pre-signed URLs.
Metadata is stored in PostgreSQL (RDS), and Redis is used for caching.

---

## 🔄 Application Flow

### Upload Flow

Frontend → Backend API → S3 (Private)

### Download Flow

Frontend → Backend API → Generate Pre-Signed URL → S3 → User Download

---

## 🔥 Features

* File upload to Amazon S3
* Secure download using pre-signed URLs
* Private S3 bucket (no public access)
* CDN delivery using CloudFront
* HTTPS enabled (ACM + NGINX)
* Redis caching for improved performance
* Dockerized backend application
* CI/CD pipeline using Jenkins
* Custom domain and DNS via Route 53

---

## ☁️ AWS Services Used

* EC2 (Backend hosting)
* S3 (File storage + frontend hosting)
* CloudFront (CDN + HTTPS)
* RDS (PostgreSQL database)
* ElastiCache (Redis caching)
* Route 53 (DNS management)
* IAM (secure access control)
* ECR (Docker image registry)

---

## 🛠️ Tech Stack

* Node.js (Express)
* React.js
* PostgreSQL
* Redis
* Docker
* NGINX

---

## 🔐 Security Implementation

* S3 bucket configured as **private**
* File access controlled via **pre-signed URLs**
* IAM roles used for secure AWS service access
* HTTPS enforced across frontend and backend
* Reverse proxy for controlled API exposure

---

## 🚀 Deployment Architecture

### Frontend

* Built with React
* Hosted on S3
* Delivered via CloudFront CDN with HTTPS

### Backend

* Node.js app running on EC2
* NGINX used as reverse proxy
* Containerized using Docker
* Docker images stored in Amazon ECR

---

## ⚙️ Setup Instructions

### 1. Clone Repository

```bash
git clone https://github.com/maheshkumar198/File_storage_aws_version
cd File_storage_aws_version
```

---

### 2. Backend Setup

```bash
cd backend
npm install
cp .env.example .env
node server.js
```

---

### 3. Frontend Setup

```bash
cd frontend
npm install
npm start
```

---

### 4. Run with Docker

```bash
docker build -t backend .
docker run -p 3000:3000 --env-file .env backend
```

---

## 🗄️ Database Setup (PostgreSQL)

This project includes a `dump.sql` file for quick database setup.

### Restore Database

```bash
psql -U your_user -d your_database -f dump.sql
```

### Example

```bash
psql -U postgres -d filestorage -f dump.sql
```

---

## 📸 Demo

(Add screenshots here)

* Upload file
* File listing
* Secure download

---

## 🎥 Demo Video

(Add YouTube or screen recording link here)

---

## 📌 Future Improvements

* Direct S3 upload using pre-signed PUT URLs
* ECS (Fargate) deployment
* CI/CD using GitHub Actions
* Monitoring using CloudWatch
* Web Application Firewall (WAF)

---

## 👨‍💻 Author

Mahesh Maharana
System Administrator → Cloud & DevOps Engineer

---
