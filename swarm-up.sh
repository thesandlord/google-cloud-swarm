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

echo "Creating Swarm"

gcloud deployment-manager deployments create $PREFIX-swarm-cluster --config options.yaml

echo "Installing Docker"

# Use GCE Metadata to know when the startup script is complete
STATUS=$(gcloud compute instances describe $PREFIX-manager --zone $ZONE | awk '/docker-install-status/{getline;print $2;}' | awk 'FNR ==1 {print $1}')
while [ "$STATUS" = "pending" ]
do
  echo $STATUS
  sleep 2
  STATUS=$(gcloud compute instances describe $PREFIX-manager --zone $ZONE | awk '/docker-install-status/{getline;print $2;}' | awk 'FNR ==1 {print $1}')
done
echo $STATUS

echo "Adding Manager to docker-machine"

docker-machine rm -f $PREFIX-manager
docker-machine create $PREFIX-manager -d google \
  --google-zone $ZONE \
  --google-project $PROJECT_ID \
  --google-use-existing

echo "Swarm Created!"
echo "eval $(docker-machine env $PREFIX-manager)"
