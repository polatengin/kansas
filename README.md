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
> ![terminal run kubectl get service command](https://github.com/polatengin/kansas/assets/118744/36c15291-51f7-40ba-8382-086abfced306)

To _intercept_ the traffic to the `web service`, run the following command:

```bash
telepresence intercept web-deployment --port 5000:80
```

Or, to _intercept_ the traffic to the `api service`, run the following command:

```bash
telepresence intercept api-deployment --port 5000:80
```

> You can add `--env-file {ENV_FILE_PATH}` argument to make the `telepresence` use the environment variables defined in the given file
>
> ```bash
> telepresence intercept api-deployment --port 5000:80 --env-file .development.env
> ```

![terminal telepresence intercept command](https://github.com/polatengin/kansas/assets/118744/9d99eb83-bea4-4619-9024-b5dae3946864)

![image](https://github.com/polatengin/kansas/assets/118744/d0215a30-dd37-417f-a475-2826038056d8)
