# 🚀 Cloud File Storage System (AWS + DevSecOps)

A production-style cloud-native file storage platform built using AWS and modern DevSecOps practices.
This project demonstrates secure file handling, CDN delivery, containerized deployment, CI/CD automation, security scanning, and production-ready infrastructure design.

---

# 🧱 Architecture Overview

* Frontend (React) is hosted on Amazon S3 and delivered globally using CloudFront CDN with HTTPS enabled via ACM
* Backend runs as a Dockerized Node.js application on EC2 behind NGINX reverse proxy with HTTPS using Let’s Encrypt
* Files are stored securely in private S3 buckets and accessed through pre-signed URLs
* PostgreSQL (Amazon RDS) is used for metadata storage
* Redis OSS (Amazon ElastiCache) is used for caching and performance optimization
* Docker images are stored in Amazon ECR
* CI/CD pipelines are automated using Jenkins with dedicated worker nodes
  <img width="1536" height="1024" alt="arch" src="https://github.com/user-attachments/assets/a11e8d03-f651-421e-b5fb-4711cb9a4817" />


---

# 🔄 Application Flow

## Upload Flow

```text
Frontend → Backend API → S3 (Private)
```

## Download Flow

```text
Frontend → Backend API → Generate Pre-Signed URL → S3 → User Download
```

---

# 🔥 Features

* Secure file upload to Amazon S3
* Secure file download using pre-signed URLs
* Private S3 bucket architecture (no public access)
* Global CDN delivery using CloudFront
* HTTPS enabled across frontend and backend
* Redis caching for performance optimization
* Dockerized backend deployment
* Automated backend CI/CD pipeline using Jenkins
* Static code analysis using SonarQube
* Security scanning using Trivy
* Quality Gate enforcement for code quality validation
* GitHub and SonarQube webhook integration
* Monorepo architecture with separate frontend and backend pipelines
* Custom domain and DNS management using Route 53

---

# ☁️ AWS Services Used

* EC2
* S3
* CloudFront
* RDS (PostgreSQL)
* ElastiCache (Redis OSS)
* Route 53
* IAM
* ECR
* ACM

---

# ⚙️ DevSecOps Pipeline

## Backend CI/CD Flow

```text
GitHub Push
   ↓
Jenkins Pipeline Trigger
   ↓
Install Dependencies
   ↓
Run Tests + Coverage
   ↓
SonarQube Code Analysis
   ↓
Quality Gate Validation
   ↓
Trivy Security Scan
   ↓
Docker Build
   ↓
Push Image to Amazon ECR
   ↓
Deploy Container on EC2
```

## CI/CD Features

* Dedicated Jenkins worker node for build execution
* Automated Docker image build and deployment
* SonarQube Quality Gate enforcement
* Trivy filesystem and image vulnerability scanning
* GitHub webhook integration
* SonarQube webhook integration
* Separate pipelines for frontend and backend services

---

# 🛠️ Tech Stack

## Backend

* Node.js
* Express.js
* PostgreSQL
* Redis

## Frontend

* React.js

## DevOps & Infrastructure

* Docker
* Jenkins
* NGINX
* SonarQube
* Trivy
* AWS

---

# 🔐 Security Implementation

* S3 bucket configured as private
* File access controlled using pre-signed URLs
* IAM roles used for secure EC2 access to S3, RDS, and ECR
* HTTPS enforced across frontend and backend
* NGINX reverse proxy for controlled API exposure
* Automated vulnerability scanning integrated into CI/CD pipeline
* Quality Gate validation to prevent insecure or low-quality deployments

---

# 🚀 Deployment Architecture

## Frontend

* React application hosted on Amazon S3
* Delivered globally using CloudFront CDN
* HTTPS enabled via ACM

## Backend

* Dockerized Node.js application running on EC2
* NGINX reverse proxy with Let’s Encrypt SSL
* Docker images managed through Amazon ECR
* Automated deployment using Jenkins CI/CD pipeline

---

# ⚙️ Setup Instructions

## 1. Clone Repository

```bash
git clone https://github.com/maheshkumar198/File_storage_aws_version
cd File_storage_aws_version
```

---

## 2. Backend Setup

```bash
cd backend

npm install

cp .env.example .env

npm start
```

---

## 3. Frontend Setup

```bash
cd frontend

npm install

npm start
```

---

## 4. Run with Docker

```bash
docker build -t backend ./backend

docker run -d \
  --name backend \
  -p 3000:3000 \
  --env-file backend/.env \
  backend
```

---

# 🗄️ Database Setup (PostgreSQL)

Restore database using:

```bash
psql -U postgres -d filestorage -f dump.sql
```

---

# 📌 Current Improvements in Progress

* Frontend CI/CD pipeline automation
* Infrastructure as Code using Terraform
* Kubernetes / EKS deployment
* Monitoring and observability integration
* Web Application Firewall (WAF)

---

# 👨‍💻 Author

Mahesh Maharana
System Administrator → Cloud & DevOps Engineer
