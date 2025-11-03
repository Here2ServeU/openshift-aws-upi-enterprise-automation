# OpenShift on AWS (UPI) — Enterprise Automation Reference

This repository demonstrates hands-on experience automating a **regulated, enterprise-grade OpenShift platform on AWS (User‑Provisioned Infrastructure — UPI)**, with **CI/CD for infra & apps**, **security & compliance mapping (NERC CIP / FISMA)**, **observability**, and **DR/backup**. It is intentionally **modular** so you can run components independently for demos or end-to-end.

> ⚠️ This is a teaching/reference repo. Use your own accounts/guardrails and review all defaults before deploying to production.

## What’s Inside
- **/infra/** — Terraform modules (AWS VPC, IAM, Route53, S3, EC2, ALB/NLB), CloudFormation samples, and Ansible playbooks for OpenShift post‑install.
- **/openshift/** — UPI installer templates (`install-config.yaml`), manifests, MachineSets, Operators (GitOps, logging, metrics), and ECR/CloudWatch/S3/Secrets Manager integrations.
- **/cicd/** — GitHub Actions & Jenkins pipelines for infra plan/apply, Ansible runs, and app deployment (Helm/ArgoCD).
- **/security-compliance/** — IAM & encryption standards, network segmentation examples, Kyverno/Gatekeeper policies, and **audit evidence templates** mapped to NERC CIP & FISMA controls.
- **/observability/** — CloudWatch/Fluent Bit/OpenTelemetry + Prometheus/Grafana configs.
- **/dr-backup/** — Velero to S3, restore runbooks, and regional DR notes.
- **/apps/sample-microservice/** — A sample containerized app with Helm chart and ArgoCD App.
- **/runbooks/** — Incident response, post‑mortem, and day‑2 ops SRE runbooks.
- **/docs/** — Architecture diagrams (Mermaid), ADRs, and a slide outline to brief stakeholders.

## Demo Paths
- **Path A (Infra only):** Terraform VPC + IAM + Route53 + S3 → Ansible post-install hardening.
- **Path B (Full UPI):** Bootstrap networking + registry + DNS → OpenShift UPI install → Operators.
- **Path C (DevSecOps):** Push app → CI scans (Trivy/Checkov) → Helm/ArgoCD deploy → Policies enforce.
- **Path D (Ops/SRE):** Generate load → observe metrics/logs/traces → perform controlled failure → post‑mortem.

## Quick Start (dry-run safe)
```bash
# 0) Pre-commit hooks & tooling (optional)
make bootstrap

# 1) Static validate Terraform, Cloud/OPA/IaC policies
make validate

# 2) Plan infra (no apply)
make tf-plan ENV=dev

# 3) Lint and unit test app
make app-test

# 4) Render Helm templates, no cluster required
make helm-dryrun
```

See each folder's README for **environment variables** and **prereqs**.
