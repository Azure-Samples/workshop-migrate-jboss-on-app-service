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

## Exercise: Create an ASE

TODO: Do we want to use an internal or external ASE?

## Exercise: Update Actions Workflow to deploy to ASE

TODO: Internal or External ASE? Should we deploy using a "pull" method, or pushing? Pulling is the secured way and closer to what a company would really do if they were using an ASE, and we'll need to use the "pull" method if they're on an Internal ASE

---

⬅️ Previous section: [4 - Setup GitHub Actions](4-set-up-github-actions.md)

➡️ Next section: [6 - Deploy to Staging Slots](6-deploy-to-stagiong-slots.md)