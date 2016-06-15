#KuberNodes

A convenience wrapper for kubectl, gcloud, gsutil and bq command line utils

##Getting Started Guide

__Step 1__: Install kubernodes
```
npm install -g kubernodes
```
__Step 2__: Create a Google Cloud Service Account

1. Browse to [Gcloud IAM](https://console.cloud.google.com/iam-admin/serviceaccounts/project?project=[PROJECT_NAME])
2. Click the "Create Service Account" Button
3. Fill out the resulting form:
    1. Service Account Name: *A label for the account*
    2. Service Account ID: *Client Email ID*
    3.  Check the box "Furnish a new private key"
    4.  Click the "Create" button
    5. Save the downloaded json file in your working dir: `./.keys/[GCLOUD_PROJECT_ID]_service_key.json`

__Step 3__: Generate your first Dockerfile

*Run the following code in your cli*
```
kn-dockerfile -p [GCLOUD_PROJECT_ID] -z [COMPUTE_ZONE] -c [CLUSTER_NAME] > .[KN_PROJECT_NAME]kube.docker

//example
kn-dockerfile -p sites -z us-central1-b -c kubernetes > .siteskube.docker
```
_Note_: Repeat this step for each project you want to configure

__Step 4__:  Build all docker files
```
kn-build [DOCKERHUB_USER/ORGANIZATION]
```
*Optional*: Push your files to your repo `kn-push [DOCKERHUB_USER/ORGANIZATION]`

__Step 5__: Run some commands
```
//get all k8s pods
kn project -r [DOCKERHUB_USER/ORG] -- get pods

//exec into a pod
kn project -r [DOCKERHUB_USER/ORG] -- exec -it [POD_NAME] bash

//run a query in big query
kn project -r [DOCKERHUB_USER/ORG] bq -- query 'select count(*) from publicdata:samples.shakespeare'

//enter a big query interactive shell
kn project -r [DOCKERHUB_USER/ORG] bq -- shell
```

__Step 6__: Do you.
