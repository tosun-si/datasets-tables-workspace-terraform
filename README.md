# datasets-tables-workspace-terraform

Project showing the use of Terraform Workspaces with a complete example on Google Cloud.\
Workspaces allow to isolate an infra with its own state on the same GCP project (for example, workspace per developers or per environment).
The deployment of IAC part is done with Cloud Build.

![terraform_with_workspaces_gcp.png](images%2Fterraform_with_workspaces_gcp.png)

## Build from local machine

### Set env vars in your Shell

```shell
export PROJECT_ID={{your_project_id}}
export LOCATION={{your_location}}
export TF_STATE_BUCKET={{your_tf_state_bucket}}
export TF_STATE_PREFIX={{your_tf_state_prefix}}
export WORKSPACE=workspacetest
export INFRA_ROOT_FOLDER=infra
export MODULE_NAME=datasets_and_tables
export GOOGLE_PROVIDER_VERSION="= 4.47.0"
```

### Plan with workspace

```shell
gcloud builds submit \
    --project=$PROJECT_ID \
    --region=$LOCATION \
    --config terraform-plan-modules.yaml \
    --substitutions _TF_STATE_BUCKET=$TF_STATE_BUCKET,_TF_STATE_PREFIX=$TF_STATE_PREFIX,_WORKSPACE=$WORKSPACE,_INFRA_ROOT_FOLDER=$INFRA_ROOT_FOLDER,_MODULE_NAME=$MODULE_NAME,_GOOGLE_PROVIDER_VERSION=$GOOGLE_PROVIDER_VERSION \
    --verbosity="debug" .
```

### Plan without workspace

```shell
gcloud builds submit \
    --project=$PROJECT_ID \
    --region=$LOCATION \
    --config terraform-plan-modules.yaml \
    --substitutions _TF_STATE_BUCKET=$TF_STATE_BUCKET,_TF_STATE_PREFIX=$TF_STATE_PREFIX,_WORKSPACE=,_INFRA_ROOT_FOLDER=$INFRA_ROOT_FOLDER,_MODULE_NAME=$MODULE_NAME,_GOOGLE_PROVIDER_VERSION=$GOOGLE_PROVIDER_VERSION \
    --verbosity="debug" .
```

### Apply with workspace

```shell
gcloud builds submit \
    --project=$PROJECT_ID \
    --region=$LOCATION \
    --config terraform-apply-modules.yaml \
    --substitutions _TF_STATE_BUCKET=$TF_STATE_BUCKET,_TF_STATE_PREFIX=$TF_STATE_PREFIX,_WORKSPACE=$WORKSPACE,_INFRA_ROOT_FOLDER=$INFRA_ROOT_FOLDER,_MODULE_NAME=$MODULE_NAME,_GOOGLE_PROVIDER_VERSION=$GOOGLE_PROVIDER_VERSION \
    --verbosity="debug" .
```

### Apply without workspace

```shell
gcloud builds submit \
    --project=$PROJECT_ID \
    --region=$LOCATION \
    --config terraform-apply-modules.yaml \
    --substitutions _TF_STATE_BUCKET=$TF_STATE_BUCKET,_TF_STATE_PREFIX=$TF_STATE_PREFIX,_WORKSPACE=,_INFRA_ROOT_FOLDER=$INFRA_ROOT_FOLDER,_MODULE_NAME=$MODULE_NAME,_GOOGLE_PROVIDER_VERSION=$GOOGLE_PROVIDER_VERSION \
    --verbosity="debug" .
```

### Destroy with workspace

```shell
gcloud builds submit \
    --project=$PROJECT_ID \
    --region=$LOCATION \
    --config terraform-destroy-modules.yaml \
    --substitutions _TF_STATE_BUCKET=$TF_STATE_BUCKET,_TF_STATE_PREFIX=$TF_STATE_PREFIX,_WORKSPACE=$WORKSPACE,_INFRA_ROOT_FOLDER=$INFRA_ROOT_FOLDER,_MODULE_NAME=$MODULE_NAME,_GOOGLE_PROVIDER_VERSION=$GOOGLE_PROVIDER_VERSION \
    --verbosity="debug" .
```

### Destroy without workspace

```shell
gcloud builds submit \
    --project=$PROJECT_ID \
    --region=$LOCATION \
    --config terraform-destroy-modules.yaml \
    --substitutions _TF_STATE_BUCKET=$TF_STATE_BUCKET,_TF_STATE_PREFIX=$TF_STATE_PREFIX,_WORKSPACE=,_INFRA_ROOT_FOLDER=$INFRA_ROOT_FOLDER,_MODULE_NAME=$MODULE_NAME,_GOOGLE_PROVIDER_VERSION=$GOOGLE_PROVIDER_VERSION \
    --verbosity="debug" .
```

## Build from the project hosted in a GITHUB repository

### Plan

```shell
gcloud beta builds triggers create manual \
  --project=$PROJECT_ID \
  --region=$LOCATION \
  --name="datasets-tables-workspace-terraform-plan" \
  --repo="https://github.com/tosun-si/datasets-tables-workspace-terraform" \
  --repo-type="GITHUB" \
  --branch="main" \
  --build-config="terraform-plan-modules.yaml" \
  --substitutions _TF_STATE_BUCKET=$TF_STATE_BUCKET,_TF_STATE_PREFIX=$TF_STATE_PREFIX,_WORKSPACE=$WORKSPACE,_GOOGLE_PROVIDER_VERSION=$GOOGLE_PROVIDER_VERSION \
  --verbosity="debug"
```

### Apply

```shell
gcloud beta builds triggers create manual \
  --project=$PROJECT_ID \
  --region=$LOCATION \
  --name="datasets-tables-workspace-terraform-apply" \
  --repo="https://github.com/tosun-si/datasets-tables-workspace-terraform" \
  --repo-type="GITHUB" \
  --branch="main" \
  --build-config="terraform-apply-modules.yaml" \
  --substitutions _TF_STATE_BUCKET=$TF_STATE_BUCKET,_TF_STATE_PREFIX=$TF_STATE_PREFIX,_WORKSPACE=$WORKSPACE,_GOOGLE_PROVIDER_VERSION=$GOOGLE_PROVIDER_VERSION \
  --verbosity="debug"
```

### Destroy

```shell
gcloud beta builds triggers create manual \
  --project=$PROJECT_ID \
  --region=$LOCATION \
  --name="datasets-tables-workspace-terraform-destroy" \
  --repo="https://github.com/tosun-si/datasets-tables-workspace-terraform" \
  --repo-type="GITHUB" \
  --branch="main" \
  --build-config="terraform-destroy-modules.yaml" \
  --substitutions _TF_STATE_BUCKET=$TF_STATE_BUCKET,_TF_STATE_PREFIX=$TF_STATE_PREFIX,_WORKSPACE=$WORKSPACE,_GOOGLE_PROVIDER_VERSION=$GOOGLE_PROVIDER_VERSION \
  --verbosity="debug"
```


