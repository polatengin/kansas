LOCATION=${2:-eastus}

PROJECT_NAME=${1:-$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 8 | head -n 1)}

TAG=$(git rev-parse --short HEAD)

az group create --name "rg-${PROJECT_NAME}" --location "${LOCATION}"

az acr create --resource-group "rg-${PROJECT_NAME}" --name "acr${PROJECT_NAME}" --sku "Basic"

az acr login --name "acr${PROJECT_NAME}"

az aks create --resource-group "rg-${PROJECT_NAME}" --name "aks-${PROJECT_NAME}" --node-count 1 --generate-ssh-keys --attach-acr "acr${PROJECT_NAME}"

az aks get-credentials --resource-group "rg-${PROJECT_NAME}" --name "aks-${PROJECT_NAME}"

echo "Waiting for cluster to be ready"
for i in {1..20}; do echo -n "."; sleep 1; done

if ! command -v telepresence &> /dev/null
then
  echo "telepresence could not be found, installing..."
  sudo curl -fL https://app.getambassador.io/download/tel2oss/releases/download/v2.16.1/telepresence-linux-amd64 -o /usr/local/bin/telepresence
  sudo chmod a+x /usr/local/bin/telepresence
fi

telepresence helm install
