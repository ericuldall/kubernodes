#KuberNodes

A convenience wrapper for kubectl, gcloud, gsutil and bq command line utils

### !! Requires [Docker](https://www.docker.com/) !!

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
kn [KN_PROJECT_NAME] -r [DOCKERHUB_USER/ORG] -- get pods

//exec into a pod
kn [KN_PROJECT_NAME] -r [DOCKERHUB_USER/ORG] -- exec -it [POD_NAME] bash

//run a query in big query
kn [KN_PROJECT_NAME] -r [DOCKERHUB_USER/ORG] bq -- query 'select count(*) from publicdata:samples.shakespeare'

//enter a big query interactive shell
kn [KN_PROJECT_NAME] -r [DOCKERHUB_USER/ORG] bq -- shell
```

__Step 6__: Enjoy easily switching between all of your google projects, with Kubernodes!

##Special Features

__Kubernodes Repo Environment__: Instead of passing the `-r` flag with every `kn` command, you can set the following env var

```
export KUBERNODES_REPO=[DOCKERHUB_USER/ORGANIZATION]
```

__Kubernodes Watch Mode__: For commands that don't require tty or stdin you can use kubernodes watch mode. Watch mode will overtake your terminal and refresh the ouptut of your command every (n) seconds.

*Here's how to watch your pods with a 5 second refresh rate*
```
kn [KN_PROJECT_NAME] --watch 5 -- get pods
```

__Kubernodes Proxy__: We've made the kubectl proxy command easitly accesible as a positional argument in kubernodes. It currently allows all paths and binds to all ip's by default and is not configurable via this shortcut, but can still be invoked as you normally would any `kn` command.

*Start your proxy*
```
kn [KN_PROJECT_NAME] proxy
```
