#!/bin/bash

terraform_create_cluster()
{
    cd terraform/
    terraform apply --auto-approve=true
}

clear_kube_konfig()
{
    rm -rf ~/.kube/config
}

set_cluster_credentials()
{
    gcloud container clusters get-credentials cluster --region region --project project
}

create_namespaces() {
    cd ../kubernetes
    kubectl apply -f namespace-prod.yml \
                  -f namespace-monitoring.yml
}

deploy_infra() {
    kubectl apply -f deployment-rabbit.yml \
                  -f service-rabbit.yml \
                  -f deployment-mongo.yml \
                  -f service-mongo.yml \
}

deploy_application() {
    kubectl apply -f deployment-crawler.yml \
                  -f service-crawler.yml \
                  -f deployment-ui.yml \
                  -f service-ui.yml \
}

install_prometheus_via_helm() {
    cd charts/prometheus
    helm upgrade --install prometheus . -f values.yaml -n monitoring
}

install_grafana_via_helm() {
    cd ../grafana
    helm upgrade --install grafana . -f values.yaml -n monitoring
}

print_web_ip() {
    kubectl get svc ui -n prod
    kubectl get svc prometheus -n monitoring
    kubectl get svc grafana -n monitoring
}

terraform_create_cluster
clear_kube_konfig
set_cluster_credentials
create_namespaces
deploy_infra
deploy_application
install_prometheus_via_helm
install_grafana_via_helm
sleep 1m
print_web_ip
