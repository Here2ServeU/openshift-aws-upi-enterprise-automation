SHELL := /bin/bash
ENV ?= dev

.PHONY: bootstrap validate tf-plan tf-apply app-test helm-dryrun

bootstrap:
	@echo "[tools] Installing pre-commit hooks..."
	@if command -v pre-commit >/dev/null; then pre-commit install; else echo "Install pre-commit to enable hooks"; fi

validate:
	@echo "[validate] Terraform fmt & validate..."; \
	if command -v terraform >/dev/null; then terraform -chdir=infra/terraform/envs/$(ENV) fmt -recursive; terraform -chdir=infra/terraform/envs/$(ENV) validate || true; else echo "terraform not found"; fi
	@echo "[validate] Checkov (IaC) if present..."; \
	if command -v checkov >/dev/null; then checkov -d infra/terraform || true; else echo "checkov not found"; fi
	@echo "[validate] OPA/Conftest (policies) if present..."; \
	if command -v conftest >/dev/null; then conftest test -p security-compliance/policies . || true; else echo "conftest not found"; fi

tf-plan:
	@echo "[tf] Planning env=$(ENV)"; \
	if command -v terraform >/dev/null; then terraform -chdir=infra/terraform/envs/$(ENV) init -upgrade; terraform -chdir=infra/terraform/envs/$(ENV) plan; else echo "terraform not found"; fi

tf-apply:
	@echo "[tf] Applying env=$(ENV)"; \
	if command -v terraform >/dev/null; then terraform -chdir=infra/terraform/envs/$(ENV) apply -auto-approve; else echo "terraform not found"; fi

app-test:
	@echo "[app] Running unit tests"; \
	if command -v npm >/dev/null; then cd apps/sample-microservice && npm i && npm t || true; else echo "npm not found"; fi

helm-dryrun:
	@echo "[helm] Rendering chart"; \
	if command -v helm >/dev/null; then helm template apps/sample-microservice/helm; else echo "helm not found"; fi
