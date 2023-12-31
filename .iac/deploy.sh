LOCATION=${2:-eastus}

PROJECT_NAME=${1:-$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 8 | head -n 1)}

TAG=$(git rev-parse --short HEAD)

az group create --name "rg-${PROJECT_NAME}" --location "${LOCATION}"

az acr create --resource-group "rg-${PROJECT_NAME}" --name "acr${PROJECT_NAME}" --sku "Basic"

az acr login --name "acr${PROJECT_NAME}"

az aks create --resource-group "rg-${PROJECT_NAME}" --name "aks-${PROJECT_NAME}" --location "${LOCATION}" --node-count 1 --no-ssh-key --attach-acr "acr${PROJECT_NAME}" --enable-addons monitoring

kubectl config unset users
kubectl config unset current-context
kubectl config unset contexts
kubectl config unset clusters

az aks get-credentials --resource-group "rg-${PROJECT_NAME}" --name "aks-${PROJECT_NAME}"

pushd ../src/api
  REPOSITORY_NAME="${PWD##*/}"

  az acr build --registry "acr${PROJECT_NAME}" --image "${REPOSITORY_NAME}:${TAG}" .

  cat ./deploy.yml | sed s/"{IMAGE}"/"acr${PROJECT_NAME}.azurecr.io\/${REPOSITORY_NAME}:${TAG}"/g | kubectl apply -f -
popd

pushd ../src/web
  REPOSITORY_NAME="${PWD##*/}"

  az acr build --registry "acr${PROJECT_NAME}" --image "${REPOSITORY_NAME}:${TAG}" .

  cat ./deploy.yml | sed s/"{IMAGE}"/"acr${PROJECT_NAME}.azurecr.io\/${REPOSITORY_NAME}:${TAG}"/g | kubectl apply -f -
popd

echo "Waiting for cluster to be ready"
for i in {0..30}; do echo -n "."; sleep 1; done
echo ""
echo "Cluster ready"

if ! command -v telepresence &> /dev/null
then
  echo "telepresence could not be found, installing..."
  sudo curl -fL https://app.getambassador.io/download/tel2oss/releases/download/v2.16.1/telepresence-linux-amd64 -o /usr/local/bin/telepresence
  sudo chmod a+x /usr/local/bin/telepresence
fi

telepresence helm install
