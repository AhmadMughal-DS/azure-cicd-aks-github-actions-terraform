# Azure CI/CD to AKS with GitHub Actions (Terraform)

> Terraform provisions ACR + AKS; a GitHub Actions pipeline builds the image, pushes to ACR, and deploys to AKS on every push to `main`.
> **Author:** Muhammad Ahmad · **IaC:** Terraform · **Cloud:** Azure

![Terraform CI](https://github.com/AhmadMughal-DS/azure-cicd-aks-github-actions-terraform/actions/workflows/terraform.yml/badge.svg)
![Terraform](https://img.shields.io/badge/Terraform-1.6%2B-7B42BC?logo=terraform&logoColor=white)
![Security](https://img.shields.io/badge/scanned-tfsec%20%7C%20checkov-success)
![Azure](https://img.shields.io/badge/Azure-AKS%20%7C%20ACR-0078D4?logo=microsoftazure&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/CI%2FCD-GitHub%20Actions-2088FF?logo=githubactions&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green)

---

## 📌 Overview

- **Terraform** builds the platform: **ACR** + **AKS** with an AcrPull role assignment.
- **GitHub Actions** (`.github/workflows/deploy.yml`) runs the pipeline: Azure login → build image → push to ACR → set AKS context → `kubectl apply`.
- **Kubernetes manifests** (`k8s/`) define a 2-replica Deployment and a LoadBalancer Service.

## 🏗️ Architecture

> 🎨 **Interactive diagram (industry-standard icons):** [open in Lucid — page 16](https://lucid.app/lucidchart/3da75ce3-ea66-4296-81b3-00d20a60435b/edit)

```mermaid
flowchart LR
    Dev([git push main])
    GHA[GitHub Actions]
    ACR[(Azure Container Registry)]
    AKS[AKS Cluster]

    Dev --> GHA
    GHA -->|docker build + push| ACR
    GHA -->|kubectl apply| AKS
    ACR -->|image pull| AKS
```

## 🚀 Setup

1. `terraform apply` to create ACR + AKS.
2. Add GitHub repo **secrets**: `AZURE_CREDENTIALS` (service principal JSON), `ACR_NAME`, `AKS_RESOURCE_GROUP`, `AKS_CLUSTER` (from Terraform outputs).
3. Push to `main` — the pipeline builds and deploys automatically.

## 🧹 Clean up

```bash
cd terraform && terraform destroy
```

## 🔐 Production hardening (next steps)

- Use **OIDC federated credentials** instead of a long-lived `AZURE_CREDENTIALS` secret.
- Add a **staging** environment and manual approval gate.
- Add **Helm** and image vulnerability scanning in the pipeline.

---

*Built and maintained by **Muhammad Ahmad**.*
