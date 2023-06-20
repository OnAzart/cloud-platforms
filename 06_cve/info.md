## Grype
1. Pull image `docker pull ghcr.io/mlflow/mlflow:v2.4.1`
2. `grype ghcr.io/mlflow/mlflow --scope all-layers | grep "Critical\|High"`

## Trivy
1.  `trivy image ghcr.io/mlflow/mlflow | grep "CRITICAL\|HIGH"`

Further learning:
- what is better to use
- how to fix vulnerabilities (flow)

---
### Lector feedback for the filter solutions:
Grype is an example of a tool written by devops/sre for devops/sre :) Maintainers expect that if it is possible to write their own go-template file, then everyone should do it instead of adding a command-line parameter:  https://github.com/anchore/grype/issues/197

Getting back to the answer. There are two more ideas on how to do filtering: 

1. create a template file like here and use it to run the scanner:

`docker run --rm --volume /var/run/docker.sock:/var/run/docker.sock --volume /workspaces/cloud_computing_course/template.tmpl:/template.tmpl --name Grype anchore/grype:latest ghcr.io/mlflow/mlflow:v2.3.0 -o template -t /template.tmpl
`
2. get json output and use **jq** to filter and format:

- `docker run --rm --volume /var/run/docker.sock:/var/run/docker.sock --name Grype anchore/grype:latest ghcr.io/mlflow/mlflow:v2.3.0 -ojson > temp.json`
and then
- `cat temp.json  | jq '.matches[] | select(.vulnerability.severity == "Critical" or .vulnerability.severity == "High") | {CVE: .vulnerability.id, name: .artifact.name, version: .artifact.version}'`

