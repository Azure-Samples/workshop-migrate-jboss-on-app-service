# Workshop Setup

This document has notes and instructions for setting up and delivering this workshop. For questions or clarification, contact Jason Freeberg.

Your participants must have a valid Azure Subscription. If the customer(s) is already using Azure, the participant can likely use their organization's development, test, or other appropriate subscription. If that is not an option for your participants, you can [request Azure Passes](#request-azure-passes) so they receive credits in a new subscription.

One week before the workshop, send your participants an email ([example](example-email.md)) the following information:
    - Azure Pass setup site (if applicable)
    - Link to the workshop repository on GitHub.com
    - Instructions to deploy the App Service Environment the day before the workshop

The participants will need to create the ASE the day before to the workshop by deploying an ARM template. It is important that the participants deploy the template before the workshop, as the ASE takes up to **3 hours** to deploy.

## Request Azure Passes

Azure Passes will provide the participants with a **new** Azure Subscription credited with a spend limit. If your participants need Azure Passes for the workshop, follow the steps below.

1. Contact Nate Ceres, let him know that you are delivering the JBoss EAP migration workshop and require Azure Passes for your participants. You will need to provide the following information:
    - The number of participants in your workshop
    - The date of the workshop
    - The value of the Azure Pass credits: **$75**
2. Once you receive the Azure Pass codes, send them [in an email](example-email.md) to the participants with instructions to redeem the code.
