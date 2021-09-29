# The App Service Environment

## Overview of the App Service Environment

In Section 1 you created an Azure Web App on the Premium V3 tier. The Premium V3 is a high-performance option for production applications, but for workloads that require even greater scale and security, there is the App Service Environment. The App Service Environment (ASE) is a single-tenant variant of App Service, meaning that the infrastructure components like the load balancers, storage, and VMs are dedicated to only your deployment. 

### Internal and External ASE

ASE's can be deployed with an internet-routable IP address or deployed within a VNet, making its IP address accessible only from other resources within the virtual network:

- [External ASE](https://docs.microsoft.com/azure/app-service/environment/create-external-ase): The external ASE is conceptually similar to the multi-tenant App Service Plan, where the applications have an internet-routable IP address and default domain name.
- [Internal ASE](https://docs.microsoft.com/azure/app-service/environment/create-ilb-ase): Internally Load Balanced (ILB) ASEs are only accessible from within the VNet, but they can still be surfaced to the public internet through upstream devices such as a WAF. The ILB ASE is appropriate for hosting intranet applications securely in the cloud, or creating internet-isolated backend applications that your frontend apps can securely connect to.

TODO: Insert side-by-side diagrams of internal and external ASEs to get the point across

### Features over multi-tenant App Service

App Service Environments are appropriate for applications that require:

- **Very high scale**: multi-tenant Plans can scale out up to 30 instances, whereas ASEs can scale to 200 instances.
- **Isolation and secure network access**: ASEs always exist in a virtual network, so you can granularly control inbound and outbound network connections.
- **High memory utilization**: The Isolated App Service Plans offer 2, 4, and 8 core machines with 8, 16, and 32 GB of memory respectively.
- **Zone redundancy**: ASEs can be [deployed into Availability Zones](https://azure.github.io/AppService/2019/12/12/App-Service-Environment-Support-for-Availability-Zones.html) to ensure a highly available deployment. Availability Zones are unique physical locations *within* an Azure Region. There are a minimum of three separate zones in supported regions, meaning if one zone suffers an outage, your applications will be available on the remaining zone.

## Exercise: Create an ILB ASE with an Azure App Gateway

The following sections will walk you through creating an App Service Environment without a public IP address. You will then create an Azure Application Gateway to front the application and expose it publicly to the internet. This architecture allows us to route all traffic through the App Gateway before it reaches our application, providing a firewall, DDoS protection, and enterprise-grade scale.

### Phase 1: Create an ILB ASE and Virtual Network

TODO: We should put this as a CLI command that they run earlier in the workshop because the ASE takes time to create -- up to 2 hours. 

TODO: Combine the ARM templates into a single template, then consolidate these CLI commands into a single run.

```bash
az deployment group create \
    --name ase_deployment \
    --resource-group $RESOURCE_GROUP \
    --template-file templates/ase-template.json \
    --no-wait \
    --parameters aseName=$WEBAPP_NAME-ase
```

```bash
az deployment group create \
    --name ase_webapp_deployment \
    --resource-group $RESOURCE_GROUP \
    --template-file templates/app-template.json \
    --parameters webAppName=$WEBAPP_NAME-ilb aseName=$WEBAPP_NAME-ase
```

> You can view the progress of the deployment in the Azure Portal by navigating to your resource group, and clicking on the **Deployments** tab.

### Phase 2: Connect to an App Gateway

NOTE: The App Gateway can take 20-30 minutes to deploy, so that should probably be in the template they run earlier. We can have them manually set up the IP rules and routing information in this exercise. It can easily be in the template instead, but then there's not much for them to do in this section.

### Phase 3: Confirm the site is served on the App Gateway

Browse to the public IP and make sure it's showing the default page for the site.

## Exercise: Update Actions Workflow to deploy to ASE

Now that our site is secured behind an App Gateway within a Virtual Network, we cannot simply push our code from GitHub Actions as we did previously. Now we will need to update our GitHub Actions workflow to publish the artifacts to a Storage Account, and trigger the site to *pull* the artifacts from the Storage Account. The site is still allowed outbound access, so it is able to pull the code from storage.

First, we will need to create a Service Principal so that our workflow can log into our Azure Subscription to create and manage the storage account.

1. Create a Service Principle for the resource group:

    ```bash
    az ad sp create-for-rbac \
        --name "{sp-name}" \
        --sdk-auth \
        --role contributor \
        --scopes /subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP
    ```

   Copy the output, you will need it in step 4.

2. Open a browser to your fork of the repository on GitHub.
3. On the repository, go to **Settings** > **Secrets** > **New repository secret**.
4. Under **Name**, enter `AZURE_CREDENTIALS`. Under **Value**, paste the output from the Azure CLI command you ran on step one.
5. Click **Add secret**

Now that the Service Principal is set as a secret in our repository, we can update our GitHub Actions workflow to use the credentials to log in.

1. Copy the template file, [`deploy-to-ilb-ase.yaml`](templates\deploy-to-ilb-ase.yaml) and paste it as a new workflow file under `.github/workflows/depoy-to-ilb-ase.yaml`.
2. Replace the placeholders at the top of the file with your webapp name and resource group name.
3. Commit this as a new workflow file on the main branch.

The commit to add the workflow file will also trigger it, so open your browser to the **Actions** tab of your repository to view the workflow's progress.

## Exercise: Connect the Web App to the PostgreSQL DB



## Resources

1. [Overview of ASEv3](https://docs.microsoft.com/azure/app-service/environment/overview)
2. [How-To configure App Gateway with an ILB ASE](https://docs.microsoft.com/azure/app-service/environment/integrate-with-application-gateway)
3. [How-To Deploy to Network-secured Web Apps](https://azure.github.io/AppService/2021/03/01/deploying-to-network-secured-sites-2.html)

---

⬅️ Previous section: [4 - Setup GitHub Actions](4-set-up-github-actions.md)

➡️ Next section: [6 - Deploy to Staging Slots](6-deploy-to-stagiong-slots.md)