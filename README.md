# 🚀 Cloud-Native File Storage Platform (AWS + Kubernetes + DevSecOps)

A production-style cloud-native file storage platform built using AWS managed services, Kubernetes, and DevSecOps practices.

This project demonstrates secure file upload/download architecture, Kubernetes deployment on Amazon EKS, AWS integrations using IRSA, HTTPS ingress routing, CI/CD automation, containerized workloads, and production-ready cloud-native infrastructure design.

---

# 🌐 Live Architecture

Frontend:

* https://maheshmaharana.online

Backend API:

* https://api.maheshmaharana.online

---

# 🧱 Architecture Overview
<img width="1536" height="1024" alt="ChatGPT Image May 12, 2026, 06_21_52 AM" src="https://github.com/user-attachments/assets/c8e53ae9-b49f-4d3f-8407-8622e3bb8e09" />


Frontend (React) is hosted on Amazon S3 and delivered globally using CloudFront CDN with HTTPS enabled using AWS ACM.

Backend runs as a containerized Node.js application on Amazon EKS (Kubernetes) using Deployments and Services.

Traffic is securely exposed using AWS Load Balancer Controller with Kubernetes Ingress and HTTPS routing using Route 53 + ACM.

Files are securely uploaded to Amazon S3 using IAM Roles for Service Accounts (IRSA) for pod-to-AWS authentication.

PostgreSQL (Amazon RDS) is used for metadata storage.

Redis OSS (Amazon ElastiCache) is used for caching and performance optimization.

Docker images are stored in private Amazon ECR repositories.

CI/CD pipelines are automated using Jenkins with security scanning and quality validation.

---

# ☁️ AWS Services Used

* Amazon EKS
* Amazon ECR
* Amazon S3
* Amazon CloudFront
* Amazon Route 53
* AWS Certificate Manager (ACM)
* Amazon RDS PostgreSQL
* Amazon ElastiCache Redis
* IAM / IRSA
* Application Load Balancer (ALB)

---

# ☸️ Kubernetes Features

* Amazon EKS cluster deployment
* Kubernetes Deployments & Services
* AWS Load Balancer Controller
* Kubernetes Ingress with HTTPS
* IRSA (IAM Roles for Service Accounts)
* Internal Kubernetes service discovery
* Secure pod-to-AWS communication
* Multi-replica backend deployment
* Private ECR image pulls
* ClusterIP internal networking

---

# 🌐 Application Flow

## Upload Flow

Frontend
↓
Backend API
↓
Amazon S3 (Private)

---

## Download Flow

Frontend
↓
Backend API
↓
Generate Pre-Signed URL
↓
Amazon S3
↓
User Download

---

# 🏗️ Production Architecture

Users
↓
CloudFront + S3 Frontend
↓
api.maheshmaharana.online
↓
ALB Ingress
↓
Amazon EKS
↓
Backend Pods
↓
RDS + Redis + S3

---

# 🔥 Features

* Secure file upload to Amazon S3
* Secure file download using pre-signed URLs
* Private S3 bucket architecture
* CloudFront CDN delivery
* HTTPS enabled across frontend and backend
* Redis caching for performance optimization
* Dockerized backend deployment
* Kubernetes-based backend orchestration
* Automated backend CI/CD pipeline
* AWS ALB Ingress Controller
* IRSA-based AWS authentication
* Internal Kubernetes networking
* Private ECR image management
* Custom domain and DNS routing using Route 53

---

# ⚙️ DevSecOps Pipeline

## Backend CI/CD Flow

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
Deploy to Amazon EKS

---

# 🔐 Security Implementation

* Private S3 bucket architecture
* Pre-signed URL based secure downloads
* IRSA-based pod authentication
* IAM-based access control
* HTTPS enforced using ACM
* Private ECR image repositories
* Kubernetes internal service networking
* Security scanning using Trivy
* SonarQube Quality Gate validation

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

* Kubernetes
* Amazon EKS
* Docker
* Jenkins
* SonarQube
* Trivy
* AWS Load Balancer Controller
* AWS Cloud Services

---

# 🚀 Deployment Architecture

## Frontend

* React application hosted on Amazon S3
* Delivered globally using CloudFront CDN
* HTTPS enabled using ACM

## Backend

* Containerized Node.js application deployed on Amazon EKS
* Kubernetes Deployments and Services
* AWS Load Balancer Controller with Ingress
* HTTPS routing using ACM + Route 53
* Private image storage using Amazon ECR
* Secure AWS access using IRSA

---

# 📂 Project Structure

```bash
File_storage_aws_version/
│
├── backend/
├── frontend/
├── k8s/
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── ingress.yaml
│   ├── serviceaccount.yaml
│   └── secrets.yaml
│
├── screenshots/
├── dump.sql
├── README.md
└── eks.config.yaml
```

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

## 4. Docker Build

```bash
docker build -t backend ./backend
```

---

## 5. Push Image to ECR

```bash
docker tag backend:latest <ECR_URI>

docker push <ECR_URI>
```

---

## 6. Deploy to Kubernetes

```bash
kubectl apply -f k8s/
```

---

# 🗄️ Database Setup (PostgreSQL)

Restore database using:

```bash
psql -U postgres -d filestorage -f dump.sql
```



---

# 📌 Current Improvements in Progress

* Infrastructure as Code using Terraform
* GitHub Actions / ArgoCD CI/CD
* Monitoring using Prometheus + Grafana + Loki
* Kubernetes autoscaling with HPA and Karpenter
* Direct S3 uploads using pre-signed URLs
* Web Application Firewall (WAF)


---

# 🔗 LinkedIn Project Post

https://www.linkedin.com/posts/mahesh-maharana-160989291_aws-kubernetes-eks-activity-7459769135259070466-hC3E?utm_source=share&utm_medium=member_desktop&rcm=ACoAAEbNQZgBL00engJLb_Uv5PuXfwlOL-g_dMs

---

# 👨‍💻 Author

Mahesh Maharana

System Administrator → Cloud & DevOps Engineer


