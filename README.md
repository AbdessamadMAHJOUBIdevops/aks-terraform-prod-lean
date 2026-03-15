# ☁️ AKS Production Lean Platform

> **Production-ready AKS platform on Azure using Terraform, GitHub Actions, and Helm.**

Une plateforme Cloud Native de bout en bout, conçue avec une approche "Secure by Default" et orientée SRE. Ce projet déploie une architecture 3-Tiers complète sur Azure Kubernetes Service (AKS) tout en optimisant les coûts pour les environnements de développement.

## 🎯 Objectifs de l'Architecture

*   **Minimal Cost (FinOps) :** Utilisation de machines `Standard_B2s` (1 nœud) et d'un workflow de destruction automatique ("Bouton Rouge") pour éviter les coûts inutilisés.
*   **Enterprise-Grade Structure :** Infrastructure as Code modulaire et packaging applicatif centralisé via Helm.
*   **Secure by Default :** Authentification OIDC (sans mot de passe) pour le CI/CD, registre ACR privé sans compte administrateur local, et identité managée (RBAC `AcrPull`) pour AKS.
*   **Fully Automated CI/CD :** Pipelines GitHub Actions gérant l'infrastructure, le build parallèle des conteneurs et les déploiements Helm.
*   **Observability & SRE :** Instrumentation Prometheus intégrée, règles d'alertes personnalisées (RAM > 90%) et notifications automatisées par e-mail.

---

## 🏗️ Architecture "As Code"

Voici la topologie complète de la plateforme, du pipeline de déploiement jusqu'au routage in-cluster.

```mermaid
graph TD
    %% CI/CD Pipeline
    subgraph CICD["GitHub Actions"]
        TF[Terraform Infra]
        BD[Build & Push Images]
        HD[Helm Deploy]
        DESTROY[Bouton Rouge - Destroy]
    end

    %% Azure Infrastructure
    subgraph AzureCloud["Azure - France Central"]
        subgraph Network["VNet: 10.0.0.0/8"]
            subgraph Subnet["AKS Subnet: 10.240.0.0/16"]
                AKS[AKS Cluster \n Node: Standard_B2s]
            end
        end
        
        ACR[Azure Container Registry \n Admin Disabled]
        RG[Resource Group]
    end

    %% Kubernetes Cluster Internals
    subgraph Kubernetes["AKS / Helm Release"]
        ING[Nginx Ingress Controller]
        
        subgraph App["Namespace: default"]
            FE[Frontend Deployment \n Nginx Alpine]
            BE[Backend Deployment \n FastAPI + Python]
            DB[(Redis)]
        end
        
        subgraph SRE["Namespace: monitoring"]
            PROM[Prometheus Operator]
            AM[Alertmanager \n Email Alerts]
            SM[ServiceMonitor \n /metrics]
        end
    end

    %% Workflows
    TF -- "OIDC Auth (No Passwords)" --> AzureCloud
    BD -- "Push Images" --> ACR
    HD -- "Deploy Chart" --> Kubernetes
    
    %% Internal Connections
    AKS -- "Managed Identity (AcrPull)" --> ACR
    ING -- "/api/*" --> BE
    ING -- "/*" --> FE
    BE -- "Reads/Writes" --> DB
    
    %% Monitoring connections
    PROM -. "Scrapes" .-> SM
    SM -. "Monitors" .-> BE
    PROM -- "Triggers Critical" --> AM



    

    