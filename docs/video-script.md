# Video Script — OpenShift on AWS (UPI) Enterprise Automation (12–15 min)

**00:00–00:45 — Hook & Outcome**
- What you’ll see: infra-as-code → OpenShift UPI → secure CI/CD → observability → DR.
- Target outcome: a repeatable, audit‑friendly platform.

**00:45–02:30 — Problem & Requirements (Regulated Utilities)**
- High availability, DR, encryption, IAM, evidence for **NERC CIP / FISMA**.

**02:30–05:30 — Architecture Walkthrough**
- Show `docs/architecture.md` (Mermaid).
- Explain VPC/IAM/Route53/S3/EC2 + UPI topology (bastion, masters, workers).

**05:30–08:00 — CI/CD for Infra & Apps**
- GitHub Actions: `infra-ci.yml`, `infra-cd.yml` with OIDC.
- Jenkins alternative: `Jenkinsfile`.
- Policy gates: Checkov + Kyverno.

**08:00–10:30 — Security/Compliance**
- IAM least-privilege, KMS encryption, network segmentation.
- Mapping table in `security-compliance/compliance-mapping/nerc_cip_fisma_matrix.md`.

**10:30–12:30 — Observability & DR**
- Fluent Bit → CloudWatch; Prom/Grafana; OTel traces.
- Velero to S3 and `runbooks/restore.md`.

**12:30–14:30 — App Demo & GitOps**
- Build sample app, push image, Helm + ArgoCD sync.
- Show policy enforcement (label requirement).

**14:30–15:00 — Close**
- Where to find code, how to extend to multi‑region DR and ECR.
