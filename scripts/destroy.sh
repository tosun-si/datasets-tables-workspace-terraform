set -e
set -o pipefail
set -u

echo "#######Destroy the Terraform module"

cd "$INFRA_ROOT_FOLDER/$MODULE_NAME" &&
  terraform apply -auto-approve &&
  terraform destroy -auto-approve
