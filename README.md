# 🚀 Cloud File Storage System (AWS + DevOps)

A full-stack cloud-based file management system built using AWS services and modern DevOps practices. This project demonstrates secure file storage, CDN delivery, containerization, and production-grade deployment.

---

## 🧱 Architecture

User → CloudFront (CDN + HTTPS) → S3 (Frontend - Private via OAC)
User → API (NGINX → Node.js on EC2) → RDS (PostgreSQL) + Redis (ElastiCache) → S3 (Private Storage)

---

## 🔥 Features

* Upload files to Amazon S3
* Secure file download using **pre-signed URLs**
* Private S3 bucket (no public access)
* CDN delivery via CloudFront
* HTTPS enabled using ACM and NGINX
* Redis caching for performance
* Dockerized backend
* CI/CD pipeline using Jenkins
* Domain and routing using Route 53

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

## 🔐 Security

* S3 bucket is **private**
* File access controlled using **pre-signed URLs**
* IAM roles used for secure service communication
* HTTPS enforced across frontend and backend

---

## 🚀 Deployment

### Frontend

* Built using React
* Deployed to S3
* Delivered via CloudFront CDN

### Backend

* Node.js application running on EC2
* Reverse proxied using NGINX
* Containerized using Docker
* Images stored in Amazon ECR

---

## ⚙️ Setup Instructions

### Clone repository

```bash
git clone https://github.com/your-username/your-repo.git
cd your-repo
```

---

### Backend Setup

```bash
cd backend
npm install
cp .env.example .env
node server.js
```

---

### Frontend Setup

```bash
cd frontend
npm install
npm start
```

---

### Docker Run

```bash
docker build -t backend .
docker run -p 3000:3000 --env-file .env backend
```

---

## 📸 Demo

(Add screenshots here)

* Upload file
* File list
* Secure download

---

## 🎥 Demo Video

(Add YouTube link here)

---

## 📌 Future Improvements

* Direct S3 upload (pre-signed PUT URLs)
* ECS deployment (Fargate)
* CI/CD using GitHub Actions
* Monitoring with CloudWatch
* WAF for security

---

## 👨‍💻 Author

Mahesh Maharana
System Administrator → Cloud & DevOps Engineer

---
