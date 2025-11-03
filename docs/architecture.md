# Architecture (High Level)

```mermaid
flowchart LR
  Dev(Dev Teams) -->|Git push| VCS[GitHub/Jenkins]
  VCS --> CI[CI: Validate/Scan/Plan]
  CI --> CD[CD: Terraform Apply + Ansible]
  CD --> AWS[AWS VPC/IAM/EC2/Route53/S3]
  AWS --> OCP[OpenShift UPI Cluster]
  OCP --> Ops[GitOps (ArgoCD) + Policies (Kyverno)]
  OCP --> Obs[Observability (Prom, Grafana, CW, OTel)]
  OCP --> DR[Velero -> S3]
```
