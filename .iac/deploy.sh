LOCATION=${2:-eastus}

PROJECT_NAME=${1:-$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 8 | head -n 1)}

az group create --name "rg-${PROJECT_NAME}" --location "${LOCATION}"

az acr create --resource-group "rg-${PROJECT_NAME}" --name "acr${PROJECT_NAME}" --sku "Basic"

az acr login --name "acr${PROJECT_NAME}"

az aks create --resource-group "rg-${PROJECT_NAME}" --name "aks-${PROJECT_NAME}" --node-count 1 --generate-ssh-keys --attach-acr "acr${PROJECT_NAME}"

az aks get-credentials --resource-group "rg-${PROJECT_NAME}" --name "aks-${PROJECT_NAME}"
