# 1 - Set up your environment

This workshop uses GitPod to provide a pre-configured development environment with Java, JBoss, and the Red Hat VS Code extensions ready-to-go! This section will guide you through the process of setting up a GitPod account and project.

## 1.1 - GitPod Setup

1. Fork [the workshop repository](https://github.com/Azure-Samples/workshop-migrate-jboss-on-app-service) into your personal GitHub account.
2. Go to [https://gitpod.io/](https://gitpod.io/) and create an account. You can use the Single-Sign-On to create a GitPod account from your GitHub account.

    ![Log into GitPod with GitHub](../img/gitpod-login-prompt.png)

3. On the next screen, select **New Project**

    ![Select new project](../img/gitpod-new-project-prompt.png)

    > Make sure you select **New Project** at this point, and not **New Workspace**.

4. Next, select **Authorize**

    ![Click authorize](../img/gitpod-authorize-prompt.png)

5. The next screen will ask which account(s) you want to authorize the application in. Select **your personal account**, which should be first in the list.

   ![Select personal account](../img/gitpod-choose-account-prompt.png)

6. Then select your fork of the workshop repository, this will give GitPod permissions to read and write to your repo. Click **Install**.

   ![Install app](../img/gitpod-select-repository-prompt.png)

7. On the next screen, select the **workshop-migrate-jboss-on-app-service** project.

    ![Select workshop-migrate-jboss-on-app-service](../img/gitpod-select-proejct.png)

8. Then select your personal account as the team to instantiate the project into.

    ![Click your personal account](../img/gitpod-select-team.png)

9. Lastly, click **New workspace**. This will start the dev container and takes about one minute.

    ![Click New Workspace](../img/gitpod-start-workspace.png)

Once the workspace launches, you will have a cloud-based VS Code IDE!

## 1.2 - Sign into Azure

The exercises in this workshop will involve creating and configuring resources from the Azure CLI and Azure Portal. The GitPod workspace already has the Azure CLI installed, but you will have to sign in from the CLI.

1. Open the VS Code terminal in GitPod by going to the existing `bash` terminal:

    <img src="../img/0-terminal.png" width=650 align=center>

2. Run the following command to start the authentication flow.

    ```bash
    az login
    ```

    Follow the instructions in the terminal output to login in.

3. To confirm your CLI is authenticated, run the following command. This will output summary information about your Azure Subscription.

    ```bash
    az account show
    ```

> If you couldn't authenticate using the browser window, you can log in using your username and password directly in the command, `az login -u johndoe@contoso.com -p verySecretPassword`. This only works if your account does **not** have 2FA enabled.

## 1.3 - Configure the workspace

Let's set some environment variables for later use. Press `F1` to open the command search window, and type `settings` into the search box, then select **Preferences: Open Workspace Settings (JSON)**. This will open a mostly empty file:

![Preferences](../img/0-prefs.png)

Replace the entire file with the below content, and then replace the placeholder values in `[]` with your unique values. Note that some of these must be globally unique, so consider adding your name or initials to them. You can optionally use a different `LOCATION` (the Azure region in which your resources will be deployed later on) if you want it to be closer to your geographic location.

> **HINT**: Valid values for `LOCATION` can be discovered by running `az account list-locations|jq '.[].name'` in the terminal.

> **HINT**: You can discover your Subscription ID with `az account show | jq -r .id`

```jsonc
{
    "terminal.integrated.env.linux": {
        // Obtain your subscription ID with hint above
        "SUBSCRIPTION_ID": "[Your Azure Subscription ID]",

        // these must be unique to you, consider using initials of your name
        "DB_SERVER_NAME": "[Your initials]-postgres-database",
        "WEBAPP_NAME": "[Your initials]-webapp",

        // this must be the same name from the ARM template you deployed earlier, and different from WEBAPP_NAME
        "ASE_WEBAPP_NAME": "[Your initials]-ase-webapp",

        // these are OK to be hard-coded
        "RESOURCE_GROUP": "jboss-rg",
        "SERVICE_PRINCIPAL_NAME": "jboss-ase-sp",
        "DB_USERNAME": "cooladmin",
        "DB_PASSWORD": "EAPonAzure1",

        // use this default, or use a location closer to you
        "LOCATION": "eastus"
    }
}
```

Save the file, then close your existing bash Terminal since it will not have these new settings (careful not to close the others!):

<img src="../img/0-bash-kill.png" width=650 align=center>

Next, open a new Terminal using the `＋` button and confirm the values are correct by running this command in the new Terminal:

```sh
for var in $(cat $GITPOD_REPO_ROOT/.vscode/settings.json \
    | grep -v '//' \
    | jq -r '."terminal.integrated.env.linux"
    | keys | join(" ")') ; do 
        val=$(eval echo \$$var); echo $var = $val
done
```

![Preferences](../img/0-env-test.png)

You should see the same values you entered. Now each new Terminal you open will have these settings. Some of the commands you run later in the workshop will reference these variables.

> **Warning:**
> 
> If you still see placeholder values instead of the values you entered into the JSON file, ensure that
> the file is saved by clicking into the file, and using `CTRL-S` (or `CMD-S` on a Mac), then close the
> newly-opened Terminal and open a new one and try the above command again until it shows correct values.

## 1.4 - Deploy the App Service Environment

> **Warning:**
>
> If you already executed this the day before the workshop, you can safely skip this section,
> as there is no need to execute it again (it will produce a deployment error that is harmless).

Later sections of this workshop will introduce and explain the App Service Environment, a single-tenant version of App Service. This service is quite large, so we will initiate the deployment for it now so that it is ready for us in the later sections of the workshop

1. First, create a resource group:

    ```bash
    az group create --name $RESOURCE_GROUP --location $LOCATION
    ```

2. Next, deploy the ARM Template to that resource group (this will take 2-3 hours to complete!). The `ASE_WEBAPP_NAME` must be globally unique, so consider using part of your name or including numbers.

    ```bash
    UNIQUE_NAME=<provide a unique name>  # upper and lowercase letters, numbers, and dashes OK
    az group create --name $RESOURCE_GROUP --location $LOCATION
    az deployment group create \
        --name ase_deployment \
        --resource-group $RESOURCE_GROUP \
        --template-uri https://raw.githubusercontent.com/Azure-Samples/workshop-migrate-jboss-on-app-service/main/templates/ase-template.json \
        --no-wait \
        --parameters webAppName=${UNIQUE_NAME}-ase-webapp
    ```

> **Tip**: You can view the progress of your deployments in the Azure Portal by navigating to your resource group, and clicking on the **Deployments** tab.

*Congratulations!* Your GitPod workspace is now ready to go. Click the link below to go to the next section

---

➡️ Next section: [2 - Learn about Azure App Service](2-learn-about-app-service.md)
