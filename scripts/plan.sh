set -e
set -o pipefail
set -u

echo "#######Plan the Terraform module"

cd "$INFRA_ROOT_FOLDER/$MODULE_NAME" &&
  terraform plan --out tfplan.out
