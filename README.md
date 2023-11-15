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

![terminal run telepresence list command](https://github.com/polatengin/kansas/assets/118744/51269112-443c-482e-bb98-a9953dbde9a3)

> You should get the same services as the result of `kubectl get services` command.
>
> ![image](https://github.com/polatengin/kansas/assets/118744/36c15291-51f7-40ba-8382-086abfced306)
