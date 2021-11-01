---
languages: 
- java
products: 
- app-service
- Application-Insights
description: "Migrate a WebLogic app to JBoss EAP on an Azure App Service Environment"
urlFragment: "/workshop-migrate-jboss-on-app-service"
---

<p align="center">
  <a href="instructions/0-environment-setup.md">
    <h1>Start here!</h1>
  </a>
</p>

# Migration workshop for JBoss on Azure

Learn how to migrate an on-premises WebLogic application to JBoss EAP using the RedHat Migration Toolkit, then set up GitHub Action workflows to deploy your app to staging environments, and secure your app using the App Service Environment.

## Get Started

### Prerequisites

- [An Azure Subscription](https://azure.microsoft.com/free/search/) (your workshop moderator may be able to provide credits)
- [A GitHub Account](https://github.com/signup)
- Basic knowledge of Java, Git, and Linux command line

### Instructions

1. [Set up your environment](instructions/0-environment-setup.md)
1. [Learn about and create an Azure App Service](instructions/1-learn-about-app-service.md)
1. [Migrate an on-prem WebLogic app to JBoss on App Service using the Migration Toolkit for Apps](instructions/2-migrate-weblogic-to-jboss.md)
1. [Create and connect a PostgreSQL application](instructions/3-create-postgres-on-azure.md)
1. [Set up GitHub Actions to build and deploy your JBoss app to App Service](instructions/4-set-up-github-actions.md)
1. [Deploy your application to the App Service Environment](instructions/5-app-service-environment.md)
1. [Set up CI workflows to deploy to staging environments](instructions/6-deploy-to-staging-slots.md)

## Resources

1. [JBoss EAP on Azure](https://docs.microsoft.com/azure/developer/java/ee/jboss-on-azure)
2. [Migrate JBoss EAP to Azure App Service](https://docs.microsoft.com/azure/developer/java/migration/migrate-jboss-eap-to-jboss-eap-on-azure-app-service?toc=/azure/developer/java/ee/toc.json&bc=/azure/developer/breadcrumb/toc.json)


test