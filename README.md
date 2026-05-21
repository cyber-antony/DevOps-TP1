# DevOps Teilprüfung 1

Laboratory CI/CD and Kubernetes deployment example for a small containerized application.

## Project purpose

This repository is a practical lab example for a DevOps test assignment. It demonstrates a simple application with frontend, backend and PostgreSQL and prepares it for CI/CD, Kubernetes deployment and GitOps.

The repository does not contain a full production infrastructure. It assumes an existing Kubernetes cluster. The infrastructure topic is documented conceptually and can be implemented with Infrastructure as Code tools such as Terraform.

The workflow also contains a manual deployment job for the local lab environment. This job is not executed automatically. It requires a self-hosted GitHub Actions runner with `kubectl` access to the private Kubernetes cluster.

## Application components

- `web`: nginx frontend
- `taskmanager`: Python backend
- `db`: PostgreSQL database

## Repository structure

- `taskmanager/` – application source and Docker Compose setup
- `k8s/taskmanager/` – Kubernetes manifests
- `.github/workflows/` – GitHub Actions workflows
- `terraform/` – simplified Infrastructure as Code example

## Local start with Docker Compose

```bash
cd taskmanager
docker compose up --build
```

Open the application in the browser:

```text
http://localhost:8080
```

Stop the local environment:

```bash
docker compose down
```

## Kubernetes deployment

The Kubernetes manifests are located in:

```text
k8s/taskmanager/
```

They assume an existing Kubernetes cluster.

Example:

```bash
kubectl apply -f k8s/taskmanager/
```

## Security note

The Kubernetes Secret in `k8s/taskmanager/03-secret.yaml` contains only demo credentials for the laboratory environment.

Real credentials must not be committed to Git. In production, secrets should be provided through a secure mechanism such as Kubernetes Secrets created from CI/CD secrets, External Secrets Operator, Sealed Secrets, Vault or a cloud secret manager.

## Infrastructure note

The application was tested on a local Kubernetes lab cluster. The full local infrastructure automation is intentionally not part of this repository, because it depends on local virtualization, routing, DNS and storage settings.

For a production-like environment, the Kubernetes infrastructure should be provisioned with Terraform or a comparable Infrastructure as Code tool.

## CI/CD status

The current GitHub Actions workflow performs a basic CI check:

```text
checkout repository
install backend dependencies
check backend syntax
build backend Docker image
build frontend Docker image
validate Docker Compose configuration
```

This is the laboratory baseline. In a production extension, the pipeline can be expanded with security scanning, image publishing to GHCR and GitOps-based deployment.

## Infrastructure and Terraform

This repository focuses on the application, CI workflow and Kubernetes deployment manifests.

The application was tested on a local Kubernetes lab cluster. The cluster itself is not created by this repository. It is assumed to exist before the Kubernetes manifests are applied.

For a production-like environment, the Kubernetes cluster could be provisioned with Terraform in a cloud environment. A simplified example is provided in:

```text
terraform/aws-cluster-example.tf
```

## Planned CI/CD and GitOps workflow

The intended target workflow is:

```text
Developer push
  ↓
GitHub Actions
  ↓
Build, test and security scan
  ↓
Push container images to GHCR
  ↓
Update Kubernetes manifests or Helm values
  ↓
Argo CD synchronizes the target Kubernetes cluster
```
