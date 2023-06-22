set -e
set -o pipefail
set -u

echo "#######Create and Select the Terraform workspace ${WORKSPACE}"

if [ -z "${WORKSPACE}" ] || [ "${WORKSPACE}" == "" ] || [ "${WORKSPACE}" == " " ]; then
  echo "#######No workspace passed, the default workspace will be used"
  exit 0
fi

cd "$INFRA_ROOT_FOLDER/$MODULE_NAME" &&
  terraform workspace new "${WORKSPACE}" || terraform workspace select "${WORKSPACE}"
