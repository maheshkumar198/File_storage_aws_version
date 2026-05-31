# 🚀 Cloud-Native File Storage Platform

### AWS • Kubernetes • Terraform • GitOps • CI/CD • Monitoring

A production-style cloud-native file storage platform built on AWS using modern DevOps practices.

This project demonstrates Infrastructure as Code (Terraform), Kubernetes orchestration, GitOps deployment with ArgoCD, CI/CD with GitHub Actions, cloud-native monitoring, autoscaling, secrets management, and production-grade AWS services.


---

# 🏗️ Architecture Overview

## Frontend Architecture

```text
User
 │
 ▼
Route53
 │
 ▼
CloudFront
 │
 ▼
Amazon S3
 │
 ▼
React Frontend
```

### Benefits

* Global CDN Delivery
* HTTPS Enabled
* High Availability
* Low Latency
* Cost Optimized

---

## Backend Architecture

```text
User
 │
 ▼
Route53
 │
 ▼
Application Load Balancer
 │
 ▼
AWS Load Balancer Controller
 │
 ▼
Amazon EKS
 │
 ├── Backend Pods
 │ ├── Deployment
 │ ├── Service
 │ └── HPA
 │
 ├── ArgoCD
 │
 ├── External Secrets Operator
 │
 ├── Prometheus
 │
 ├── Grafana
 │
 └── Alertmanager
 │
 ▼
RDS PostgreSQL
 │
 ▼
Redis
```

---

# ⚙️ CI/CD Pipeline

## Frontend Pipeline

```text
Developer
    │
    ▼
GitHub
    │
    ▼
GitHub Actions
    │
    ▼
React Build
    │
    ▼
Upload to Amazon S3
    │
    ▼
CloudFront Cache Invalidation
    │
    ▼
Production
```

---

## Backend Pipeline

```text
Developer
    │
    ▼
GitHub
    │
    ▼
GitHub Actions
    │
    ▼
Docker Build
    │
    ▼
Amazon ECR
    │
    ▼
Update GitOps Manifest
    │
    ▼
Git Push
    │
    ▼
ArgoCD
    │
    ▼
Amazon EKS
```

---

# 🔄 GitOps Workflow

ArgoCD continuously watches Git repositories and synchronizes changes automatically.

```text
GitHub
   │
   ▼
ArgoCD
   │
   ▼
Amazon EKS
```
<img width="1900" height="809" alt="image" src="https://github.com/user-attachments/assets/df2ed2bd-7b18-4d12-bf4f-5eb206658f69" />

### Features

* Automated Deployments
* Self-Healing
* Drift Detection
* Rollback Support
* Version Control

---

# ☁️ AWS Services Used

### Compute

* Amazon EKS
* Amazon EC2

### Storage

* Amazon S3

### Database

* Amazon RDS PostgreSQL
* Redis

### Networking

* Amazon VPC
* Route53
* CloudFront
* Application Load Balancer

### Security

* AWS Certificate Manager
* AWS Secrets Manager
* IAM

### Containers

* Amazon ECR

### Monitoring

* CloudWatch

---

# ☸️ Kubernetes Features

* Deployments
* Services
* Ingress
* Namespaces
* ConfigMaps
* Secrets
* Horizontal Pod Autoscaler
* Metrics Server
* AWS Load Balancer Controller
* External Secrets Operator
* Prometheus
* Grafana
* Alertmanager
* Self-Healing
* Rolling Updates

---

# 🔐 Security Implementation

## Secrets Management

Secrets are stored in:

* AWS Secrets Manager
* Kubernetes Secrets
* External Secrets Operator

Managed Secrets:

* Database Credentials
* Redis Credentials
* SMTP Credentials
* Application Secrets

---

## SSL/TLS

* AWS ACM Certificates
* HTTPS Enabled
* Secure API Communication

---

## Access Control

* IAM Roles
* Kubernetes RBAC
* Least Privilege Principle

---

# 📊 Monitoring & Observability

A complete monitoring stack is deployed using kube-prometheus-stack.

## Components

### Prometheus

Collects metrics from:

* Nodes
* Pods
* Services
* Kubernetes Components

### Grafana

Provides dashboards for:

* Cluster Monitoring
* Resource Utilization
* Application Metrics
* Infrastructure Health

### Alertmanager

Routes alerts through:

* Email Notifications

### Node Exporter

Provides:

* CPU Metrics
* Memory Metrics
* Disk Metrics
* Network Metrics

### Kube State Metrics

Provides Kubernetes object metrics.

### Metrics Server

Provides metrics required by HPA.

---

# 🚨 Alerting System

Alertmanager is integrated with Gmail SMTP.

## Configured Alerts

### Infrastructure Alerts

* High CPU Usage
* High Memory Usage
* Node Down

### Kubernetes Alerts

* Pod CrashLooping
* Pod Not Ready
* Deployment Replica Mismatch

### Application Alerts

* Backend Service Down

---

# 📈 Horizontal Pod Autoscaling

Backend services scale automatically based on CPU utilization.

### Configuration

```yaml
minReplicas: 2
maxReplicas: 5
targetCPUUtilizationPercentage: 70
```

### Scaling Flow

```text
CPU Usage Increases
        │
        ▼
Metrics Server
        │
        ▼
HPA
        │
        ▼
Scale Backend Pods
```

---

# 📦 Application Flow

## Upload Flow

```text
User
 │
 ▼
React Frontend
 │
 ▼
Backend API
 │
 ▼
PostgreSQL Metadata
 │
 ▼
Success Response
```

---

## Download Flow

```text
User
 │
 ▼
React Frontend
 │
 ▼
Backend API
 │
 ▼
Database Lookup
 │
 ▼
File Response
```

---

# 🛠️ Tech Stack

## Frontend

* React.js
* JavaScript
* HTML
* CSS

## Backend

* Node.js
* Express.js

## Database

* PostgreSQL

## Cache

* Redis

## Containers

* Docker

## Orchestration

* Kubernetes

## Infrastructure as Code

* Terraform

## GitOps

* ArgoCD

## CI/CD

* GitHub Actions

## Monitoring

* Prometheus
* Grafana
* Alertmanager

## Cloud

* AWS

---

# 📂 Project Structure

```text
.
├── terraform/
│   ├── modules/
│   ├── environments/
│   └── main.tf
│
├── gitops/
│   ├── applications/
│   ├── backend/
│   ├── monitoring/
│   ├── external-secrets/
│   └── ingress/
│
├── frontend/
│
├── backend/
│
├── .github/
│   └── workflows/
│
├── docs/
│   └── screenshots/
│
└── README.md
```

---

# 🚀 Deployment Steps

## Provision Infrastructure

```bash
terraform init
terraform plan
terraform apply
```

---

## Configure EKS

```bash
aws eks update-kubeconfig \
  --region ap-south-1 \
  --name <cluster-name>
```

---

## Install ArgoCD

```bash
kubectl create namespace argocd

kubectl apply \
-f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml \
-n argocd
```

---

## Deploy Applications

```bash
kubectl apply -f applications/
```

---

# 📸 Screenshots

## Architecture Diagram

*Add Screenshot*

## ArgoCD Dashboard

<img width="1897" height="867" alt="image" src="https://github.com/user-attachments/assets/c71b328a-eff3-41c6-bff9-e8a0f6296035" />
<img width="1894" height="872" alt="image" src="https://github.com/user-attachments/assets/8ed9296b-79d5-41ce-a09d-e870e669bb01" />

## Grafana Dashboard

<img width="1895" height="866" alt="image" src="https://github.com/user-attachments/assets/2cf8c097-e926-49be-bc08-7583c2789a3c" />
<img width="1905" height="873" alt="image" src="https://github.com/user-attachments/assets/40eb26cf-bb9c-48ce-bd41-7b4e8950e743" />


---

# 🎯 DevOps Concepts Demonstrated

* Infrastructure as Code
* Kubernetes Operations
* GitOps
* CI/CD
* Cloud Networking
* Monitoring & Alerting
* Autoscaling
* Secrets Management
* Containerization
* Production Deployments
* Cloud Security

---

# 🚀 Future Enhancements

* Loki Log Aggregation
* Karpenter

---

# 👨‍💻 Author

### Mahesh Maharana

Cloud & DevOps Engineer

GitHub: https://github.com/maheshkumar198

LinkedIn: www.linkedin.com/in/mahesh-maharana-160989291

---

⭐ If you found this project useful, please consider giving it a star.
