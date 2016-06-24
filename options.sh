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

#Project Options
PROJECT_ID=smart-spark-93622

#Cluster Details
NUM_MANAGERS=1 #Need at least one manager
NUM_WORKERS=2
SWARM_SECRET="somestring"
PREFIX=my-swarm

#Machine Options (Worker)
WORKER_MACHINE_TYPE=n1-standard-1
WORKER_ZONE=us-central1-f
WORKER_DISK=100

#Machine Options (Manager)
MANAGER_MACHINE_TYPE=n1-standard-1
MANAGER_ZONE=us-central1-f
MANAGER_DISK=100

#Advanced Settings
ENGINE_INSTALL_URL=experimental.docker.com
TAGS=swarm-cluster