# 🚀 Strapi Deployment on AWS ECS Fargate (Task 8)

This project demonstrates a complete production-style deployment of a **Strapi v5 application** on **AWS ECS Fargate**, fully managed using **Terraform (modular approach)** and automated via **GitHub Actions CI/CD**.

It includes centralized logging and monitoring using **Amazon CloudWatch Logs & Dashboard**.

---

## 📌 Architecture Overview

Strapi App → Docker → Amazon ECR → ECS Fargate → Public Subnet  
Infrastructure as Code → Terraform (Modular)  
CI/CD → GitHub Actions  
Monitoring → CloudWatch Logs + Dashboard  

---

## 🏗️ Tech Stack

- **Strapi v5**
- **Docker**
- **AWS ECS Fargate**
- **Amazon ECR**
- **Terraform (Modular Architecture)**
- **Amazon CloudWatch**
- **GitHub Actions (CI/CD)**
- **S3 Backend for Terraform State**

---

---

## ⚙️ Infrastructure Components

### ✅ ECS Fargate
- ECS Cluster
- ECS Task Definition
- ECS Service
- Public subnet networking
- Auto-assign public IP enabled

### ✅ Amazon ECR
- Docker image repository
- Image scanning enabled
- Lifecycle policy (retain last 5 images)

### ✅ CloudWatch
- Log Group: `/ecs/gaurav-strapi-task8`
- Dashboard with:
  - CPU Utilization
  - Memory Utilization
  - Task Count
  - Network In
  - Network Out

### ✅ Security
- Security Group allowing inbound:
  - Port 1337 (Strapi)
- Outbound: 0.0.0.0/0

### ✅ Terraform Backend
- Remote backend using S3
- Ensures consistent state management in CI/CD

---

## 🔁 CI/CD Workflow (GitHub Actions)

The workflow automatically:

1. Checkout repository
2. Configure AWS credentials
3. Initialize & apply Terraform
4. Build Docker image
5. Push image to Amazon ECR
6. Deploy new ECS task revision

Triggered on: push → main branch

---

## 🌍 How to Access the Application

1. Go to:
   AWS Console → ECS → Cluster → Service → Tasks

2. Open the running task

3. Click the ENI link

4. Copy the **Public IPv4 address**

5. Open in browser:
http://PUBLIC-IP:1337/admin


---

## 🔐 Environment Variables (Production)

The following environment variables are configured in ECS Task Definition:

- NODE_ENV=production
- APP_KEYS
- API_TOKEN_SALT
- ADMIN_JWT_SECRET
- JWT_SECRET

These are required for Strapi production mode.

---

## 📊 Monitoring

CloudWatch Dashboard includes:

- ECS CPU Utilization
- ECS Memory Utilization
- Task Count
- Network In
- Network Out


---

## 🚀 How to Deploy (From Scratch)

1. Clone repository
2. Configure GitHub Secrets:
   - AWS_ACCESS_KEY_ID
   - AWS_SECRET_ACCESS_KEY
   - AWS_ACCOUNT_ID

3. Push to main branch

GitHub Actions will handle the deployment automatically.

---

## 🧠 Key Learnings

- Modular Terraform architecture
- ECS Fargate networking concepts
- Public vs Private subnet routing
- CloudWatch monitoring setup
- Production environment variables for Strapi
- Remote Terraform state management
- CI/CD automation with GitHub Actions

---

## 📈 Future Improvements

- Add Application Load Balancer (ALB)
- Enable HTTPS with ACM
- Replace SQLite with Amazon RDS
- Enable Auto Scaling
- Store secrets in AWS Secrets Manager

---



