# Checkov
Scans cloud infrastructure configurations to find misconfigurations. *Terraform, Kubernetes, Helm, ...*

## Instruction
1. `pip3 install checkov`
2. `checkov -d 03__faas_terraform`


### Fixed:
- SQS query encrypted
- Concurrency of both lambda functions is limited to 2

### Important from lection:
- (Almost) each cloud has built-in policy-engines. 
- (Almost) each tool/framework has own policy-engine. 
- There are also open source solutions, for example, Open Policy Agent, Checkov, Polaris to name a few.
