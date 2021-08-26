---
languages: 
- java
products: 
- app-service
- Application-Insights
description: "Migrate a WebLogic app to JBoss EAP on an Azure App Service Environment"
urlFragment: "/workshop-migrate-jboss-on-app-service"
---

# Migration workshop for JBoss on Azure

Learn how to migrate an on-premises WebLogic application to JBoss EAP using the RedHat Migration Toolkit, set up GitHub Action to deploy your app to staging environments, and secure your app using the App Service Environment.

## Getting Started

### Prerequisites

- [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli)
- [Java 11](https://docs.microsoft.com/java/openjdk/download)
- [Visual Studio Code](https://code.visualstudio.com/)
- [An Azure Subscription](https://azure.microsoft.com/free/search/)

## Set up

1. Create a fork of the repository, you will need your own fork to set up GitHub Actions later.
2. Clone your fork locally repository: `git clone https://github.com/<your-username>/workshop-migrate-jboss-on-app-service.git`

## Instructions

1. Learn about Azure App Service 
1. [Migrate an on-prem WebLogic app to JBoss on App Service using the Migration Toolkit for Apps](1-migrate-weblogic-to-jboss/README.md)
2. [Set up GitHub Actions to build and deploy your JBoss app to App Service](/2-set-up-github-actions/README.md)
3. [Learn about the App Service Environment](/3-ase-overview/README.md)
4. [Update GitHub Actions to deploy to the App Service Environment](/4-update-github-actions/README.md)
5. [Set up CI workflows to deploy to staging and UAT environments](/5-deploy-staging-uat/README.md)

## Resources

1. [JBoss EAP on Azure](https://docs.microsoft.com/azure/developer/java/ee/jboss-on-azure)
2. [Migrate JBoss EAP to Azure App Service](https://docs.microsoft.com/azure/developer/java/migration/migrate-jboss-eap-to-jboss-eap-on-azure-app-service?toc=/azure/developer/java/ee/toc.json&bc=/azure/developer/breadcrumb/toc.json)

