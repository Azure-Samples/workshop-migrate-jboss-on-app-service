# Migration workshop for JBoss on Azure

Learn how to migrate an on-premesis WebLogic application to JBoss EAP using the RedHat Migration Toolkit, set up GitHub Action to deploy your app to staging environments, and secure your app using the App Service Environment.

## Getting Started

### Prerequisites

- Azure CLI 
- Java 11 
- Visual Studio Code
- An Azure Subscription

## Set up

1. Create a fork of the repository, you will need your own fork to set up GitHub Actions later.
2. Clone your fork locally repository: `git clone https://github.com/<your-username>/workshop-migrate-jboss-on-app-service.git`

## Intructions

1. Migrate an on-prem WebLogic app to JBoss on App Service using the Migration Toolkit for Apps
2. Set up GitHub Actions to build and deploy your JBoss app to App Service
3. Learn about the App Service Environment
4. Update GitHub Actions to deploy to the App Service Environment
5. Set up CI workflows to deploy to staging and UAT environments

## Resources

1. [JBoss EAP on Azure](https://docs.microsoft.com/en-us/azure/developer/java/ee/jboss-on-azure)
2. [Migrate JBoss EAP to Azure App Service](https://docs.microsoft.com/en-us/azure/developer/java/migration/migrate-jboss-eap-to-jboss-eap-on-azure-app-service?toc=/azure/developer/java/ee/toc.json&bc=/azure/developer/breadcrumb/toc.json)
