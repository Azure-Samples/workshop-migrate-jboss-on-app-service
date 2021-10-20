# Stage deployments for testing

As the saying goes, *"Friends don't let friends deploy directly to production"*... but until now that's exactly what we have been doing! In this section, you will set up GitHub Actions workflows to deploy your apps to a staging environment on our App Service Environment so that you can test and confirm your new build is running properly before promoting it to production.

## App Service Deployment Slots

App Service has a feature known as [Deployment Slots](https://docs.microsoft.com/azure/app-service/deploy-staging-slots), which are independent staging environments with their own configuration and file system. This means you can safely deploy your new releases to these slots, connect them to non-production services (such as a test database or message queue), and *swap* the slot into production when you're satisfied.

![Slot swap diagram](../img/6-slot-swap-diagram.PNG)
> In the diagram above, a PR is merged into the main branch on a repository. This triggers a deployment to a staging slot, which is eventually swapped into production.

Deployment slots are flexible: you can create slots to deploy the contents of Pull Requests to expedite the review and testing process, or you can have long-lived slots for development, QA, and UAT environments and "promote" builds through each environment. You can have up to 20 deployment slots on the IsolatedV2 and PremiumV3 compute tiers.

## Exercise: workflow to deploy Pull Requests

- Exercise: Create a workflow that creates a slot for every PR, deploys the site, and comments on the PR with a link to the stage URL
