#!/bin/bash

echo; echo "Clean up Kubernetes resources if haven't:"

kubectl delete -f https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/examples/2048/2048_full.yaml

echo; echo "Not found error is OK to ignore. It means the resource has already been cleaned up."
