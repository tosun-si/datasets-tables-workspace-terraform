set -e
set -o pipefail
set -u

echo "#######Apply the Terraform module"

cd "$INFRA_ROOT_FOLDER/$MODULE_NAME" &&
  terraform apply -auto-approve tfplan.out
