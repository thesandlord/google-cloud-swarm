# 	Copyright 2016, Google, Inc.
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

# get cluster info from options.yaml
PREFIX=$(awk '{for(i=1;i<=NF;i++) if ($i=="prefix:") print $(i+1)}' options.yaml)
ZONE=$(awk '{for(i=1;i<=NF;i++) if ($i=="zone:") print $(i+1)}' options.yaml)
PROJECT_ID=$(gcloud config list project | awk 'FNR ==2 { print $3 }')

echo "Deleting Swarm Deplyoment"

yes y | gcloud deployment-manager deployments delete $PREFIX-swarm-cluster

echo 'Deleting Tokens'

gcloud compute project-info remove-metadata --keys $PREFIX-swarm-worker-token,$PREFIX-swarm-manager-token

echo "Deleting Manager from docker-machine"

docker-machine rm -f $PREFIX-manager

echo "Cluster Deleted"