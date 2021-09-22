# Deploy with GitHub Actions

## Overview of GitHub Actions

GitHub Actions help you automate tasks within your software development life cycle. GitHub Actions are event-driven, meaning that you can run a series of commands after a specified event has occurred. For example, every time someone creates a pull request for a repository, you can automatically run a command that executes a software testing script. GitHub Actions is based on `.yaml` files in the `.github/workflows/` directory of your application which describe the automation to be run. Let's learn more about the terminology and hierarchy of GitHub Actions...

### GitHub Actions Terminology

The first step in getting started with GitHub Actions is to create a **workflow file** in the `.github/workflows/` directory of your repository. The workflow file is composed of one or more **jobs**, and jobs are composed of one or more **steps**. The diagram below illustrates the hierarchy of these terms:

![Diagram of Jobs](4-overview-github-actions-simple.png)

- **Events**: All workflows are triggered by events, whether that's a opening or closing Pull Request, pushing a commit, creating a release, or by a cron schedule. You can also filter the events, such as only triggering a workflow for commits on a specified branch, or if a commit makes changes in a specific directory.
- **Workflows**: The workflow file defines the events that trigger the workflow, the name of the workflow, and the 
- **Jobs**: A job is a set of steps that execute on the same runner. By default, a workflow with multiple jobs will run those jobs in parallel. You can also configure a workflow to run jobs sequentially. For example, a workflow can have two sequential jobs that build and test code, where the test job is dependent on the status of the build job. If the build job fails, the test job will not run.
- **Steps**: A step is an individual task that can run commands in a job. A step can be either an **action** or a shell command. Each step in a job executes on the same runner, allowing the actions in that job to share data with each other.
- **Actions**: Actions are standalone commands that are combined into steps to create a job. Actions are the smallest portable building block of a workflow. You can create your own actions, or use actions created by the GitHub community. To use an action in a workflow, you must include it as a step.

### Example workflow

This is a simple example workflow that is triggered whenever a pull request is opened, and whenever a new commit is pushed to an open PR.

```yaml
name: CI for Pull Requests

on:
  pull_request:

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout the repo
      uses: actions/checkout@v2
      
    - name: Set up Java 11
      uses: actions/setup-java@v2
      with:
        java-version: 11
    
    - name: Build application and run tests
      run: mvn clean install
```

## Exercise: Add a CI workflow for Pull Requests

To get introduced to GitHub Actions, let's set up some simple CI checks for your repository. Create a workflow file in your repository that runs whenever a PR is opened for the main branch and whenever a commit is pushed to the main branch. The workflow should run set up Java 11 and use Maven to build the application, essentially adding minimal CI checks to the repo.

To accomplish this task you can go to the **Actions** tab of your fork and scroll down, there will be a template workflow titled, **Java with Maven**. Click **Set up this workflow** to enter the in-browser editor to get the workflow set up.

![Java with Maven template](img/4-java-with-maven-template-card.png)

Once you have the workflow set up, you can open a simple PR to test that the workflow runs and that the application builds correctly.

> Hint: Having trouble finding the template workflow? [Try this link](https://github.com/actions/starter-workflows/blob/main/ci/maven.yml).

## Exercise: Add a workflow to deploy your application

Now that we have a simple CI workflow to build and test our application for Pull Requests, let's add another workflow file to build and *deploy* our JBoss EAP application whenever there is a commit on the main branch.

TODO: The default workflow file from the Azure Portal only deploys a .war file. If we need to deploy the startup script and other files at this point, then this section needs to also cover creating a Service Principal for the workflow and setting it as a Secret on the repository so we can use the Azure CLI or Maven plugin to deploy. The `webapps-deploy` action does not yet support the deployment API that we need for multi-file deployments.
  - Example:  https://github.com/Azure-Samples/migrate-javaee-app-to-azure-training/tree/main/step-05-setup-github-actions 

---

⬅️ Previous section: [3 - Create PostgreSQL on Azure](3-create-postgres-on-azure.md)

➡️ Next section: [5 - Create an App Service Environment](5-app-service-environment.md)