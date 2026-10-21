# Architecture Diagram — Azure CI/CD to AKS

## Lucid diagram

- **Master Lucid document (all 30 diagrams, icon style):** https://lucid.app/lucidchart/3da75ce3-ea66-4296-81b3-00d20a60435b/edit
- This project is **page 16** of that document.

## Lucid prompt (reusable)

```
Create an Azure CI/CD diagram titled "Azure CI/CD to AKS with GitHub Actions".
A git push to main triggers GitHub Actions. GitHub Actions does docker build and push
to Azure Container Registry (ACR), then runs kubectl apply to deploy to an AKS cluster;
AKS pulls the image from ACR. Label the arrows. Clean, professional colors.
```

## Mermaid source

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
