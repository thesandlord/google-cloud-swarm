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

echo "Deleting Manager(s)"

for i in `seq 1 $NUM_MANAGERS`
do
    docker-machine rm -f $PREFIX-manager-$i &
done

echo "Deleting Workers(s)"

for i in `seq 1 $NUM_WORKERS`
do
    docker-machine rm -f $PREFIX-worker-$i &
done

wait
echo "Cluster Deleted"