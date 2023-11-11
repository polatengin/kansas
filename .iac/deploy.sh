LOCATION=${2:-eastus}

PROJECT_NAME=${1:-$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 8 | head -n 1)}

az group create --name "rg-${PROJECT_NAME}" --location "${LOCATION}"
