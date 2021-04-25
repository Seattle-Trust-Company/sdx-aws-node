# SDX AWS Node

## Description
This repository contains the necessary scripts and data files to start up ethereum mining pools in AWS.

## Project Structure
- `data`: Contains configuration files including the genesis block, pool keys, and the default password. Since we aren't mining real ETH, we are okay with exposing our password and keystore folders.
- `Dockerfile`: used for creating Docker image. Modify the `POOL` variable to be either `bigsur`, `breakbot`, `babyrays`, `samesame`, or `tahoe`.
- `node.sh`: Creates a new node and connects to the bootnode running on AWS.

## Basic Flow
- We have pre-initialized geth accounts stored within `data`.
- Dockerfile copies the specified POOL keystore and the `node.sh` script to the /app working directory.
- `node.sh` will be run on a docker container and set up a node using the passed keystore and genesis file. It automatically unlocks the account to begin mining immediately.

## To Build
Configurations before building
```console
-- AWS ECR Url --
$ export ECR_URL='409345029529.dkr.ecr.us-east-2.amazonaws.com'

-- With the appropriate certifications, you can login to AWS ECR --
$ aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin ${ECR_URL}

-- Example Pools and Versions (update accordingly) --
$ export POOL='bigsur'
$ export VERSION='1.0'
```

Push to AWS ECR
```console
$ docker build -t ${ECR_URL}/${POOL}:${VERSION} .
$ docker push ${ECR_URL}/${POOL}:${VERSION}
```

## To Run Locally
Make sure the bootnode is running on AWS at the specified elastic IP address within `node.sh`.  

Start-up node
```console
$ docker run -p 30303:30303 -p 8000:8000 ${ECR_URL}/${POOL}:${VERSION}
```

## AWS Flow
- Each pool has a corresponding ECS cluster.
- Each pool has a corresponding task that defines which keystore file to use.
- Each pool has a service that determines how many tasks to run.
- Each container requires 3 GB memory and 2 vCPU.
- Make sure AWS bootnode is up and running with correct elastic IP address.
- After pushing to each pool's AWS ECR repo, update the corresponding task.
- Then update the corresponding calling service. The instances running the service should automatically update alongside the service update.
