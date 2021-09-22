# The App Service Environment

## Overview of the App Service Environment

In Section 1 you created an Azure Web App on the Premium V3 tier. The Premium V3 is a high-performance option for production applications, but for workloads that require even greater scale and security, there is the App Service Environment. The App Service Environment (ASE) is a single-tenant variant of App Service, meaning that the infrastructure components like the load balancers, storage, and VMs are dedicated to only your deployment. 

### Internal and External ASE

ASE's can be deployed with an internet-routable domain name, or deployed within a Vnet--making it only accessible from other resources within the virtual network.

- Internal ASE:
- External ASE:

### Features over multi-tenant App Service

TODO

## Exercise: Create an ASE

TODO

## Exercise: Update Actions Workflow to deploy to ASE

TODO
TBD: Internal or External ASE? Should we deploy using a "pull" method, or pushing? Pulling is the secured way and closer to what a company would really do if they were using an ASE

---

⬅️ Previous section: [4 - Setup GitHub Actions](4-set-up-github-actions.md)

➡️ Next section: [6 - Deploy to Staging Slots](6-deploy-to-stagiong-slots.md)