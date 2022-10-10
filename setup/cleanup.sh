#!/bin/bash

EKS_CLUSTER_NAME=eks-alb-2048game

echo; echo "Clean up Kubernetes resources if haven't:"

kubectl delete -f https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/examples/2048/2048_full.yaml

echo; echo "'Not found error' is OK to ignore. It means the resource has already been cleaned up."

echo; echo "Delete EKS cluster:"
sleep 30
eksctl delete cluster --name $EKS_CLUSTER_NAME --wait

if [ $? -eq 0 ]; then
    echo; echo "EKS cluster and its resources have been deleted."
else
    echo; echo "Try again by deleting the EKS cluster via CloudFormation."
    sleep 10
    aws cloudformation delete-stack --stack-name eksctl-$EKS_CLUSTER_NAME-cluster
    aws cloudformation wait stack-delete-complete --stack-name eksctl-$EKS_CLUSTER_NAME-cluster
    if [ $? -eq 0 ]; then
        echo; echo "EKS cluster and its resources have been deleted."
    fi
fi