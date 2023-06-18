# Checkov
Scans cloud infrastructure configurations to find misconfigurations. *Terraform, Kubernetes, Helm, ...*

## Instruction
1. `pip3 install checkov`
2. `checkov -d 03__faas_terraform`


### Fixed:
- SQS query encrypted
- Concurrency of both lambda functions is limited to 2
