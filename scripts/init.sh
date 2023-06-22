set -e
set -o pipefail
set -u

echo "#######Init the Terraform module"

cd "$INFRA_ROOT_FOLDER/$MODULE_NAME" &&
  terraform init \
    -backend-config="bucket=${TF_STATE_BUCKET}" \
    -backend-config="prefix=${TF_STATE_PREFIX}/${MODULE_NAME}"
