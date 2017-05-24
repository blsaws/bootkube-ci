#!/bin/bash
# Copyright 2017 The Bootkube-CI Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Cleaning up nodes is simple:
printf "Removing bootkube environment from system..."
{ sudo systemctl stop kubelet.service
  sudo docker rm bootkube-render
  sudo docker stop $(sudo docker ps -a | grep k8s| cut -c1-20 | xargs sudo docker stop)
  sudo docker rm -f $(sudo docker ps -a | grep k8s| cut -c1-20 | xargs sudo docker stop)
  sudo docker rm -f $(sudo docker ps -a | grep bootkube| cut -c1-20 | xargs sudo docker stop)
  sudo docker rm -f $(sudo docker ps -a | grep bootkube| cut -c1-20 | xargs sudo docker stop)
  sudo rm -rf /etc/kubernetes/
  sudo rm -rf /var/etcd
  sudo rm -rf /var/run/calico
  sudo rm -rf /var/run/flannel
  sudo rm -rf /var/run/kubernetes/*
  sudo rm -rf /var/lib/kubelet/*
  sudo rm -rf /var/run/lock/kubelet.lock
  sudo rm -rf /var/run/lock/api-server.lock
  sudo rm -rf /var/run/lock/etcd.lock
  sudo rm -rf /var/run/lock/pod-checkpointer.lock
  sudo rm -rf /usr/local/bin/bootkube
  sudo rm -rf /usr/local/bin/kubectl
  sudo rm -rf /usr/local/bin/helm
  sudo rm -rf /opt/cni
  sudo rm -rf /home/$USER/.bootkube
  sudo ip link set flannel.1 down
} &> /dev/null
printf "\nCOMPLETE!\n"
