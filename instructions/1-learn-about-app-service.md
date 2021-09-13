# About Azure App Service

1. Overview of App Service features & benefits, quick comparison to other Azure services
2. Exercise: Create a multi-tenant web app from the CLI
3. Introduce the Azure Portal and how to navigate it, navigate to the web app

## Introduction

Azure App Service is a proven managed platform for hosting web and API applications for businesses large and small. App Service has multiple pricing tiers to fit the needs of any organization, and has a number of features for development, management, compliance, and operation:

### Developer features

- Integration with all kinds of developer tools to empower developers to be more productive, including IntelliJ and Eclipse, Maven and Gradle, GitHub Actions and DevOps, and more.
- Staging environments to deploy new code or test configuration changes safely before rolling out to production.
- A guided troubleshooting experience to help developers diagnose and solve configuration errors, slow applications, and more.

TODO: Some diagram or image of deployment slots

### Management features

- Integration with Application Insights makes it easy to monitor your production applications, set up alerts for slow or failing requests, and view a live map of your entire deployment and the connections between your services

TODO: Add App Insights image

### Compliance and Operation

- The App Service Environment is a single-tenant variant of App Service, which allows you to meet stringent compliance requirements and secure your deployment more than the multi-tenant variant of App Service (more on this in section 5)
- Azure Monitor provides a central storage sink to collect and store your application logs for auditing requirements

## Architecture

- App Service Plans
- Scaling horizontally and behind the load balancer
- 

## Exercise: Create an Azure Web App

To get started, let's create a JBoss EAP web app using the Azure CLI. First, we will need to create an App Service Plan

```bash
az appservice plan create --name "workshop-app-service-plan" `
    --resource-group $RESOURCE_GROUP `
    --sku P1V3
```

```bash
az webapp create --name $WEBAPP_NAME \
    --resource-group $RESOURCE_GROUP \
    --
```
