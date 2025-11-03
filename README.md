
# Case Study: Automating Enterprise-Grade OpenShift on AWS (User-Provisioned Infrastructure)

- **Author:** Emmanuel Naweji  
- ** Senior Cloud / DevOps / SRE Engineer | PhD Candidate in Computer Science (AI & ML Focus)  
- **Project Type:** Enterprise Automation Case Study  
- **Technologies:** OpenShift, AWS, Terraform, Ansible, CloudFormation, GitHub Actions, Jenkins, ArgoCD, Helm, Kyverno, Prometheus, Grafana, Velero, OTel  

---

## Overview

This repository is a **real-world automation case study** demonstrating how enterprises can design, deploy, and operate a **secure, resilient, and compliant Red Hat OpenShift platform on AWS** using **User-Provisioned Infrastructure (UPI)**.  

The project was developed to show end-to-end automation — from infrastructure provisioning to application delivery — with integrated **security, observability, and disaster recovery** aligned to **NERC CIP**, **FISMA**, and other regulated industry standards.

It’s designed for:
- **Organizations** modernizing workloads from VMs to containers.
- **Consultants** building production-ready platforms for clients.
- **Engineers** seeking hands-on experience automating enterprise environments.

---

## Business Challenge

Many enterprise clients in regulated industries (utilities, energy, finance, healthcare) face similar problems:
1. **Manual provisioning** of clusters and AWS resources causing delays.
2. **Lack of repeatability** across environments (Dev, Test, Prod).
3. **Security & compliance complexity** (NERC CIP, FISMA, corporate IT standards).
4. **Limited observability** for root-cause and performance analysis.
5. **Unclear disaster recovery (DR)** and backup strategies.

---

## Solution Summary

This project provides a **modular, auditable, and fully automated platform** integrating:

| Capability | Implementation |
|-------------|----------------|
| **Infrastructure as Code (IaC)** | Terraform, Ansible, CloudFormation |
| **Cluster Automation** | Red Hat OpenShift UPI on AWS |
| **CI/CD Pipelines** | GitHub Actions + Jenkins |
| **Security & Compliance** | IAM, KMS, Kyverno, OPA, Checkov, Conftest |
| **Monitoring & Logging** | CloudWatch, Prometheus, Grafana, OpenTelemetry |
| **Backup & DR** | Velero to S3, multi-region replication |
| **App Delivery** | Helm + ArgoCD GitOps |
| **Documentation & Evidence** | Runbooks, architecture diagrams, compliance mapping |

---

## Architecture Overview

```mermaid
flowchart LR
  Dev(Developers) -->|Push Code| GitHub
  GitHub --> CI[GitHub Actions / Jenkins]
  CI --> CD[Terraform + Ansible + Helm]
  CD --> AWS[AWS: VPC, IAM, S3, Route53, EC2]
  AWS --> OCP[Red Hat OpenShift (UPI)]
  OCP --> GitOps[ArgoCD, Helm]
  OCP --> Sec[Kyverno, OPA Policies]
  OCP --> Obs[Prometheus, Grafana, CloudWatch, OTel]
  OCP --> DR[Velero Backups to S3]
```

---

## Technical Components

### 1. Infrastructure Automation (`infra/`)
- **Terraform modules** for VPC, IAM, Route53, S3, EC2, Load Balancers.
- **Environment structure** (`envs/dev`, `envs/test`, `envs/prod`) for isolation.
- **CloudFormation** templates for regulated organizations that require CFN-based change control.

### 2. OpenShift UPI Deployment (`openshift/`)
- **Custom `install-config.yaml`** for AWS UPI topology.
- **Manifests for image registry**, storage via S3, and integration with ECR.
- **Ansible post-install playbooks** for OS hardening and NTP enforcement.

### 3. CI/CD Integration (`.github/workflows/` + `Jenkinsfile`)
- GitHub Actions with OIDC → Terraform apply (no static credentials).
- Jenkins pipeline alternative for hybrid environments.
- Integrated **Checkov**, **Conftest**, and **OPA** for IaC policy enforcement.

### 4. Security & Compliance (`security-compliance/`)
- **IAM least privilege policies** for OpenShift nodes and CI/CD.
- **KMS encryption** for S3, EBS, etcd, and backups.
- **Kyverno** and **OPA** policies for runtime enforcement.
- **Compliance Matrix** mapped to NERC CIP and FISMA families.

| Control Area | Tool/Feature | Evidence |
|---------------|--------------|----------|
| IAM & Access | AWS IAM, Terraform | Policy JSON exports |
| Encryption | AWS KMS, Terraform | CMK configurations |
| Change Management | Git + GitHub Actions | PR approvals, logs |
| Backup & DR | Velero, S3 | Backup reports |
| Logging & Monitoring | CloudWatch, Grafana | Dashboards & metrics |

---

### 5. Observability & SRE (`observability/`)
- **Fluent Bit → CloudWatch** for container logs.
- **Prometheus + Grafana** for cluster metrics.
- **OpenTelemetry Collector** to integrate traces and logs for AI-driven incident prediction.

---

### 6. Backup & Disaster Recovery (`dr-backup/`)
- **Velero to S3** with encryption and versioning.
- **Restore runbook** included for DR testing.
- **Optional multi-region DR** using S3 replication and Route 53 failover.

---

### 7. Sample Microservice (`apps/sample-microservice/`)
A demo app to validate CI/CD + GitOps:
- Node.js REST API → Dockerized → Deployed via Helm + ArgoCD.
- ArgoCD automatically syncs from GitHub.
- Kyverno ensures policies (labeling, non-root user, etc.) before deployment.

---

### 8. Documentation & Runbooks (`docs/`, `runbooks/`)
- **Architecture Diagrams (Mermaid)**
- **Incident Response & Post-Mortem Templates**
- **Compliance Evidence Templates**
- **Video Script** for showcasing your project

---

## Quick Start

```bash
# 1. Validate Terraform, policies, and syntax
make validate

# 2. Run Terraform plan (dry-run)
make tf-plan ENV=dev

# 3. Deploy infrastructure (if approved)
make tf-apply ENV=dev

# 4. Deploy sample microservice
make helm-dryrun
```

Or trigger the **GitHub Actions workflows** directly:
- `infra-ci.yml` → PR validation and security scans  
- `infra-cd.yml` → Manual dispatch to apply infrastructure changes

---

## Lessons Learned

- **UPI is powerful** for regulated environments because it allows custom control of each node, IAM, and security group.
- **GitHub Actions with OIDC** eliminates long-lived AWS credentials, simplifying compliance.
- **Policy-as-Code** reduces audit fatigue — every control (IAM, encryption, backup) is version-controlled.
- **Velero + S3 versioning** ensures recoverability and meets DR testing requirements.
- **Observability and automation** transform incident response from reactive to proactive.

---

## Extend This Project

You can adapt this repository to:
1. Deploy to **multi-cloud** (Azure AKS, GCP GKE) using **Crossplane**.
2. Add **FinOps monitoring** with Kubecost and CloudWatch metrics dashboards.
3. Integrate **AI-based log analysis** using OpenAI API or MLflow anomaly detection.
4. Expand compliance coverage with **FedRAMP** or **ISO 27001** mappings.
5. Integrate **Vault or AWS Secrets Manager** for secret rotation and encryption.

---

## Use Cases

| Use Case | Description |
|-----------|-------------|
| **Consulting Project** | Build OpenShift UPI automation for a client’s Dev/Test/Prod setup with compliance deliverables. |
| **Corporate DevOps Practice** | Demonstrate readiness for NERC CIP or FISMA audits. |
| **Training Program** | Use this repo as a lab for DevOps students or interns to learn regulated infrastructure automation. |
| **Personal Portfolio** | Showcase real-world enterprise automation capabilities for interviews or proposals. |

---

## Video Walkthrough (Suggested Format)

**Duration:** 12–15 minutes  
**Script Location:** [`docs/video-script.md`](docs/video-script.md)

**Outline:**
1. Problem & context (why automation matters)
2. Architecture diagram walkthrough
3. Terraform & CI/CD pipeline overview
4. OpenShift + AWS integration
5. Security & compliance highlights
6. Observability & DR demo
7. GitOps deployment
8. Closing remarks & lessons learned

---

## Results

- Fully automated infrastructure and OpenShift provisioning on AWS
- Security and compliance baked into the CI/CD pipeline  
- Standardized, repeatable environment setup for Dev/Test/Prod  
- Real-world evidence for audits and consulting clients  
- Demonstrated leadership in DevSecOps, SRE, and automation best practices  

---

## License
Licensed under the **Apache 2.0 License** — use freely for your own organization or client engagements.

---

## 👤 Author

**Emmanuel Naweji**  
DevOps | SRE | Cloud & AI Platform Engineer  
- PhD Candidate, Computer Science (AI/ML) | National University  
- [LinkedIn](https://linkedin.com/in/ready2assist) | [GitHub](https://github.com/Here2ServeU)

> “Automation is not just about efficiency — it’s about resilience, trust, and readiness for the future.”

