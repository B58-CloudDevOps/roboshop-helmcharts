echo "Authenticaing to EKS ${1}"
aws eks update-kubeconfig --name ${1}-eks
kubectl get nodes 

ARGO_URL="argocd.cloudapps.today"
ARGO_PWD=$(kubectl get secret argocd-initial-admin-secret -o json -n argocd | jq '.data.password'| xargs | base64 -d)
argocd login $ARGO_URL  --username admin --password $ARGO_PWD --grpc-web

pwd

argocd app list |grep "argocd/${2}"
if [ $? -ne 0 ]; then
    echo "creating ${1} ${2} app"
    argocd app create ${2} --repo https://github.com/B58-CloudDevOps/roboshop-helmcharts.git --path . --dest-namespace default --dest-server https://kubernetes.default.svc --values env-${1}/${2}.yaml --sync-policy auto  --helm-set imageTag=${3} #--grpc-web
    argocd app wait ${2}
fi

echo "Deployment of ${2} ${3} version to ${1} eks cluster" 
argocd app set ${2} --parameter imageTag=${3}

echo "Deployment of version ${3} is completed"
argocd app wait ${2}
kubectl get pods | grep ${2}