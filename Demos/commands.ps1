####### CREATE CLUSTER  ###########

# Create a resource group
az group create --name democluster1-rg --location eastus


# Create a cluster
az aks create --resource-group democluster1-rg --name demoAKSCluster1 --node-count 1 --enable-addons monitoring --generate-ssh-keys

# Get Credentials for cluster
az aks get-credentials --resource-group democluster1-rg --name demoAKSCluster1



############ POD DEMO ############
# create pod
kubectl apply -f pod.yaml

#view pods
kubectl get pods

#describe pod
kubectl describe pod label-demo


# Execute container nginx
kubectl exec -it label-demo -c nginx -- /bin/bash

# Get OS of Container
cat /etc/os-release

#Exit Container
exit
#delete pod
kubectl delete -f pod.yaml



############### DEMO DEPLOYMENT  ########################
# Deployment Manifest
kubectl apply -f azure-vote.yaml
# View pods
kubectl get pods

#Delete pod to show it comes back replace pod name with pod name
# provided by get pods above


kubectl delete pod azure-vote-front-78dc4ff55b-tfb9v

#Check to see if it came back

kubectl get pods
# Get external ip to view app running
kubectl get service azure-vote-front --watch

## Update replicas of frontend to 3
kubectl apply -f azure-vote.yaml

# View pods
kubectl get pods

# Delete deployment
kubectl delete -f azure-vote.yaml


################## JOBS DEMO  #############################

#You can run the example with this command:
kubectl apply -f https://kubernetes.io/examples/controllers/job.yaml

#You can check the status with this with kubectl describe :
kubectl describe jobs/pi

#To list all the Pods that belong to a job, use a command like:
$pods=$(kubectl get pods --selector=job-name=pi --output=jsonpath='{.items[*].metadata.name}')
echo $pods

#View the standard output of one of the pods:
kubectl logs $pods


#You can clean up with the example with this command:
kubectl delete -f https://kubernetes.io/examples/controllers/job.yaml

############# Clean up Azure Resources #############


# Azure az help
az group delete --help

# Clean Azure Resources
az group delete -n democluster1-rg

############# OTHER COMMANDS ############
## Alias
Set-Alias -Name k -Value kubectl

k version


## Other commands

kubectl api-resources


# Run apply k
k apply -f pod.yaml

# Short get pods
k get po

# Delete pod with force and no wait
k delete pod label-demo --grace-period=0 --force

# Help and Output options 
k create  --help
k apply --help
k apply -f pod.yaml -o json
# Explains
k explain pods.spec








