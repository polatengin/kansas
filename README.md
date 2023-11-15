# kansas project

Using `telepresence` tool to debug a kubernetes service locally.

## Install Telepresence

Use the following link to install `telepresence` on your local machine:

[telepresence](https://www.telepresence.io/docs/latest/quick-start/?os=gnu-linux)

## Deploy sample project to AKS (Azure Kubernetes Service)

Use the [deploy.sh](./.iac/deploy.sh) script to deploy the sample project to AKS.

## Run Telepresence

Run the following command to get list of services available in the cluster;

```bash
telepresence list
```

> You should get the same services as the result of `kubectl get svc` command.
