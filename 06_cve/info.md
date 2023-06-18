## Grype
1. Pull image `docker pull ghcr.io/mlflow/mlflow:v2.4.1`
2. `grype ghcr.io/mlflow/mlflow --scope all-layers | grep "Critical\|High"`

## Trivy
1.  `trivy image ghcr.io/mlflow/mlflow | grep "CRITICAL\|HIGH"`

Further learning:
- what is better to use
- how to fix vulnerabilities (flow)

