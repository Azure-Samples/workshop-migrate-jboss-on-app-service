# Set up your environment

This workshop uses GitPod to provide a pre-configured development environment with Java, JBoss, and the Red Hat VS Code extensions ready-to-go! This section will guide you through the process of setting up a GitPod account and workspace.

## GitPod Setup

1. Fork [the workshop repository](https://github.com/Azure-Samples/workshop-migrate-jboss-on-app-service) into your personal GitHub account.
2. Go to [https://gitpod.io/](https://gitpod.io/) and create an account. You can use the Single-Sign-On to create a GitPod account from your GitHub account.
3. To create a GitPod workspace, navigate to your fork of the workshop repository on GitHub (ex: **https://github.com/JoeSmith/workshop-migrate-jboss-on-app-service**) and prefix the entire URL with **gitpod.io/#**, like this:

    ```text
    gitpod.io/#https://github.com/JoeSmith/workshop-migrate-jboss-on-app-service
    ```

    This will open a new GitPod workspace using the configuration files in the repo.

4. Once the workspace launches, you will have a cloud-based VS Code IDE!

## Sign into Azure

The exercises in this workshop will involve creating and configuring resources from the Azure CLI and Azure Portal. The GitPod workspace already has the Azure CLI installed, but you will have to sign in from the CLI.

1. Open the VS Code terminal in GitPod by going to **Terminal** > **New Terminal**.
2. Run the following command. This will open a new browser window to log into your Azure account.

    ```bash
    az login
    ```

    Complete the login process in the new window.

3. To confirm your CLI is authenticated, run the following command. This will output summary information about your Azure Subscription.

    ```bash
    az account show
    ```

> If you couldn't authenticate using the browser window, you can log in using your username and password directly in the command, `az login -u johndoe@contoso.com -p verySecretPassword`. This only works if your account does **not** have 2FA enabled.

## Configure the workspace

- TODO: set the env vars for GitPod.
  - SUBSCRIPTION_NAME
  - WEBAPP_NAME
  - RESOURCE_GROUP

*Congratulations!* Your GitPod workspace is now ready to go. Click the link below to go to the next section

---

➡️ Next section: [1 - Learn about Azure App Service](2-migrate-weblogic-to-jboss.md)