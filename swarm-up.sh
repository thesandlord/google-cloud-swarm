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

# include options.sh for all the variables
source ./options.sh

echo "Creating Manager(s)"

for i in `seq 1 $NUM_MANAGERS`
do
    docker-machine rm -f $PREFIX-manager-$i && \
    docker-machine create $PREFIX-manager-$i \
        --engine-install-url $ENGINE_INSTALL_URL \
        -d google \
        --google-machine-type $MANAGER_MACHINE_TYPE \
        --google-zone $MANAGER_ZONE \
        --google-disk-size $MANAGER_DISK \
        --google-tags $TAGS \
        --google-project $PROJECT_ID &
done

echo "Creating Workers(s)"

for i in `seq 1 $NUM_WORKERS`
do
    docker-machine rm -f $PREFIX-worker-$i && \
    docker-machine create $PREFIX-worker-$i \
        --engine-install-url $ENGINE_INSTALL_URL \
        -d google \
        --google-machine-type $WORKER_MACHINE_TYPE \
        --google-zone $WORKER_ZONE \
        --google-disk-size $WORKER_DISK \
        --google-tags $TAGS \
        --google-project $PROJECT_ID &
done

echo "Waiting for Instance(s) to Start"
wait

echo "Instance(s) Created"

SWARM_MANAGER_INTERNAL_IP=$(gcloud compute instances describe $PREFIX-manager-1 --zone $MANAGER_ZONE --format=text | grep '^networkInterfaces\[[0-9]\+\]\.networkIP:' | sed 's/^.* //g')

echo $MANAGER_IP

echo "Creating Swarm"
eval $(docker-machine env $PREFIX-manager-1)

docker swarm init --secret $SWARM_SECRET

echo "Adding Manager(s)"

for i in `seq 2 $NUM_MANAGERS`
do
    eval $(docker-machine env $PREFIX-manager-$i)
    docker swarm join $SWARM_MANAGER_INTERNAL_IP:2377
done

echo "Adding Workers(s)"

for i in `seq 1 $NUM_WORKERS`
do
    eval $(docker-machine env $PREFIX-worker-$i) && \
    docker swarm join $SWARM_MANAGER_INTERNAL_IP:2377 --secret $SWARM_SECRET &
done
wait

echo "Swarm Created!"
echo "eval $(docker-machine env $PREFIX-manager-1)"
