# 🚀 Cloud-Native File Storage Platform (AWS + Kubernetes + DevOps)

A production-style cloud-native file storage platform built using AWS, Kubernetes, Terraform, GitOps, and modern DevOps practices.

This project demonstrates end-to-end infrastructure provisioning, application deployment, GitOps workflows, monitoring, alerting, autoscaling, secrets management, and cloud-native operations.

---

# 🏗 Architecture Overview

The application is deployed on Amazon EKS and follows GitOps principles using ArgoCD.

```text
Users
   │
   ▼
Route53
   │
   ▼
AWS ALB Ingress Controller
   │
   ▼
EKS Cluster
   ├── Frontend Pods
   ├── Backend Pods
   ├── HPA
   ├── Metrics Server
   ├── Prometheus
   ├── Grafana
   ├── Alertmanager
   └── External Secrets Operator
          │
          ▼
AWS Secrets Manager

Backend Pods
   ├── PostgreSQL (Amazon RDS)
   └── Redis Cache

Prometheus
   │
   ▼
Alertmanager
   │
   ▼
Email Notifications
```

---

# ☁️ AWS Services Used

* Amazon EKS
* Amazon VPC
* Amazon EC2
* Amazon RDS PostgreSQL
* Amazon ECR
* Amazon Route53
* AWS Certificate Manager (ACM)
* AWS Secrets Manager
* Application Load Balancer (ALB)
* IAM Roles for Service Accounts (IRSA)
* CloudWatch

---

# ☸️ Kubernetes Features

* Amazon EKS Cluster
* Namespace Isolation
* Deployments
* Services
* Ingress Resources
* AWS Load Balancer Controller
* External Secrets Operator
* Horizontal Pod Autoscaler (HPA)
* Metrics Server
* Prometheus Monitoring
* Grafana Dashboards
* Alertmanager Notifications
* ConfigMaps
* Secrets
* Rolling Updates
* Self-Healing Pods

---

# 🔄 GitOps Workflow

ArgoCD continuously monitors the Git repository and automatically synchronizes changes to the Kubernetes cluster.

```text
Developer
    │
    ▼
GitHub Repository
    │
    ▼
ArgoCD
    │
    ▼
Amazon EKS
```

Benefits:

* Automated deployments
* Version-controlled infrastructure
* Self-healing applications
* Drift detection
* Easy rollback

---

# 🔐 Security Implementation

### Secrets Management

Sensitive information is stored in:

* AWS Secrets Manager
* External Secrets Operator
* Kubernetes Secrets

Secrets include:

* PostgreSQL credentials
* Redis credentials
* SMTP credentials
* Application secrets

### SSL/TLS

* AWS Certificate Manager
* HTTPS enabled
* Route53 DNS management

### Access Control

* IAM Roles
* Kubernetes RBAC
* Least Privilege Principle

---

# 📊 Monitoring & Observability

The platform includes a complete monitoring and alerting stack.

## Components

* Prometheus
* Grafana
* Alertmanager
* Node Exporter
* Kube State Metrics
* Metrics Server

---

## Metrics Collected

### Infrastructure Metrics

* CPU Usage
* Memory Usage
* Disk Usage
* Network Usage
* Node Health

### Kubernetes Metrics

* Pod Status
* Deployment Health
* Restart Counts
* Resource Requests
* Resource Limits

### Application Metrics

* Backend Availability
* Service Health
* API Response Metrics

---

# 🚨 Alerting System

Alertmanager is configured with Gmail SMTP integration.

Email notifications are automatically sent for:

### Critical Alerts

* High CPU Usage
* High Memory Usage
* Node Down
* Backend Service Down

### Warning Alerts

* Pod CrashLooping
* Deployment Replica Mismatch
* Pod Not Ready

---

# 📈 Horizontal Pod Autoscaler (HPA)

The backend application automatically scales based on CPU utilization.

### Configuration

* Minimum Replicas: 2
* Maximum Replicas: 5
* Target CPU Utilization: 70%

### Scaling Flow

```text
High CPU Usage
       │
       ▼
Metrics Server
       │
       ▼
HPA
       │
       ▼
Scale Pods Automatically
```

---

# 📦 Application Flow

## Upload Flow

```text
User
 │
 ▼
Frontend
 │
 ▼
Backend API
 │
 ▼
PostgreSQL Metadata
```

---

## Download Flow

```text
User
 │
 ▼
Frontend
 │
 ▼
Backend API
 │
 ▼
Database Lookup
 │
 ▼
Return File
```

---

# 🛠 Tech Stack

## Frontend

* React.js
* JavaScript
* HTML
* CSS

## Backend

* Node.js
* Express.js

## Database

* PostgreSQL (Amazon RDS)

## Cache

* Redis

## Containerization

* Docker

## Orchestration

* Kubernetes

## Cloud

* AWS

## Infrastructure as Code

* Terraform

## GitOps

* ArgoCD

## Monitoring

* Prometheus
* Grafana
* Alertmanager

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
│   ├── argocd/
│   ├── frontend/
│   ├── backend/
│   ├── monitoring/
│   └── external-secrets/
│
├── frontend/
│
├── backend/
│
├── docs/
│   └── screenshots/
│
└── README.md
```

---

# 🚀 Deployment Process

## 1. Provision Infrastructure

```bash
terraform init
terraform plan
terraform apply
```

---

## 2. Configure EKS

```bash
aws eks update-kubeconfig \
  --region ap-south-1 \
  --name <cluster-name>
```

---

## 3. Install ArgoCD

```bash
kubectl create namespace argocd

kubectl apply \
-f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml \
-n argocd
```

---

## 4. Deploy Applications

```bash
kubectl apply -f applications/
```

ArgoCD automatically deploys:

* Backend
* Monitoring Stack
* External Secrets
* Ingress

---

# 📸 Screenshots

## Architecture Diagram

*Add architecture screenshot here*

## ArgoCD Dashboard

*Add screenshot here*

## Grafana Dashboard

*Add screenshot here*

## Prometheus Alerts

*Add screenshot here*

## Alert Email Notification

*Add screenshot here*

## HPA Scaling

*Add screenshot here*

---

# 🎯 Key DevOps Concepts Demonstrated

* Infrastructure as Code (Terraform)
* GitOps (ArgoCD)
* Kubernetes Operations
* Cloud Networking
* Secrets Management
* Monitoring & Alerting
* Autoscaling
* Containerization
* CI/CD Practices
* Production Architecture Design

---

# 🚀 Future Enhancements

* Loki Log Aggregation
* Karpenter Auto Node Scaling

---

# 👨‍💻 Author

**Mahesh Maharana**

Cloud & DevOps Engineer

* LinkedIn: https://linkedin.com
* GitHub: https://github.com/maheshkumar198

---

⭐ If you found this project useful, consider giving it a star.
