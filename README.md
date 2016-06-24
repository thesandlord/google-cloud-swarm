# google-cloud-swarm
Scripts to create and manage a Docker Swarm cluster on Google Cloud Platform
### Prerequisites
- [Docker 1.12](https://docs.docker.com/engine/installation/)
- [Docker-Machine 0.8.0](https://docs.docker.com/machine/install-machine/)
- [Google Cloud SDK](http://cloud.google.com/sdk)

### Before you start
Make sure you create a [Google Cloud Project](http://console.cloud.google.com/project)

Login: ```gcloud init```

### Create a Cluster
   ```./swarm-up.sh```
   
   By default, this will create a cluster with one manager and two workers. You can edit this and more options in the [options.sh](options.sh) file.
### Delete a Cluster
   ```./swarm-down.sh```
   
### Options
Edit the [options.sh](options.sh) file to specify your options.
- `PROJECT_ID`= **REQUIRED** - The Google Cloud Project ID
- `NUM_MANAGERS`= Number of Managers for the Cluster - *default: 1*
- `NUM_WORKERS`= Number of Workers for the Cluster - *default: 2*
- `SWARM_SECRET`= The secret required to join the Cluster
- `PREFIX`= All nodes in the Swarm will start with this Prefix. This allows you to have multiple Swarms in the same project.
- `WORKER_MACHINE_TYPE`= [Google Cloud Machine Type](https://cloud.google.com/compute/docs/machine-types#standard_machine_types) for the Worker nodes - *default: n1-standard-1*
- `WORKER_ZONE`= [Google Cloud Zone](https://cloud.google.com/compute/docs/regions-zones/regions-zones) for the Worker nodes - *default: us-central1-f*
- `WORKER_DISK`= Disk size in GB for the Worker nodes - *default: 100*
- `MANAGER_MACHINE_TYPE`= [Google Cloud Machine Type](https://cloud.google.com/compute/docs/machine-types#standard_machine_types) for the Manager nodes - *default: n1-standard-1*
- `MANAGER_ZONE`= [Google Cloud Zone](https://cloud.google.com/compute/docs/regions-zones/regions-zones) for the Manager nodes - *default: us-central1-f*
- `MANAGER_DISK`= Disk size in GB for the Manager nodes - *default: 100*
- `ENGINE_INSTALL_URL`= [The Docker Engine Download URL](https://docs.docker.com/machine/reference/create/) - *default: experimental.docker.com*
- `TAGS`= [Google Cloud Instance Tags](https://cloud.google.com/compute/docs/label-or-tag-resources) for the nodes in the cluster - *default: swarm-cluster*
   
##### Notes:
- This is not an official Google product
- This is not an official Docker product
- Only tested on OSX