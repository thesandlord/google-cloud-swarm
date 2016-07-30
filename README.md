# google-cloud-swarm
Scripts to create and manage a Docker Swarm cluster on Google Cloud Platform.
### Prerequisites
- [Docker 1.12](https://docs.docker.com/engine/installation/)
- [Docker-Machine 0.8.0](https://docs.docker.com/machine/install-machine/)
- [Google Cloud SDK](http://cloud.google.com/sdk)

### Before you start
Make sure you create a [Google Cloud Project](http://console.cloud.google.com/project)

Login: 

`gcloud init`

### Create a Cluster
   `./swarm-up.sh`
   
   By default, this will create a cluster with one manager and two workers. You can edit this and more options in the [options.yaml](options.yaml) file.
### Delete a Cluster
   `./swarm-down.sh`

### Resize a Cluster
   `./swarm-resize.sh <NUM_WORKERS>`

### Options
Edit the [options.yaml](options.yaml) file to specify your options.

## Cluster Config

- Cluster Configuration Options
  - `prefix` = All nodes in the Swarm will start with this Prefix. This allows you to have multiple Swarms in the same project.
  - `zone` = [Google Cloud Zone](https://cloud.google.com/compute/docs/regions-zones/regions-zones) for the nodes - *default: us-central1-f*
- Manager Options
    - `manager_machine_type` = [Google Cloud Machine Type](https://cloud.google.com/compute/docs/machine-types#standard_machine_types) for the Manager nodes - *default: n1-standard-1*
    - `manager_disk` = Disk size in GB for the Manager nodes - *default: 100*
- Worker Options
  - `num` = Number of Workers for the Cluster - *default: 2*
  - `worker_machine_type` = [Google Cloud Machine Type](https://cloud.google.com/compute/docs/machine-types#standard_machine_types) for the Worker nodes - *default: n1-standard-1*
  - `worker_disk` = Disk size in GB for the Worker nodes - *default: 100*

## How it works

These scripts are simple wrappers around a set of Deployment Manager templates.

It launches a VM for the Swarm Manager, and a Managed Instance Group for the workers.

This allows you to dynamically scale the number of workers as well as easily create Network Load Balancers that target the worker nodes.

Docker-Machine is used to connect to the Manager node over a secure TLS connection

##### Notes:
- This is not an official Google product
- This is not an official Docker product
- Only tested on OSX
