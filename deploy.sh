# This script is called in the GitHub Actions workflows that deploy the app and supporting files to the ASE.

if [ -z "$SLOT_NAME" ]
then
    echo "Not slot name given, deploying to the production slot."
    SITE_URI="https://management.azure.com/subscriptions/${SUBSCRIPTION}/resourceGroups/${RESOURCE_GROUP}/providers/Microsoft.Web/sites/${WEBAPP}/extensions/onedeploy?api-version=2020-12-01"
else
    # Append slot to URI
    echo "Deploying to slot: ${SLOT_NAME}"
    SITE_URI="https://management.azure.com/subscriptions/${SUBSCRIPTION}/resourceGroups/${RESOURCE_GROUP}/providers/Microsoft.Web/sites/${WEBAPP}/slots/${SLOT_NAME}/extensions/onedeploy?api-version=2020-12-01"
fi

echo "Site URI: ${SITE_URI}"

# Deploy WAR file
az storage blob upload --account-name $STORAGE_ACCOUNT -c $CONTAINER -f ROOT.war
WAR_URL=$(az storage blob generate-sas --full-uri --permissions r --expiry $EXPIRY --account-name $STORAGE_ACCOUNT -c $CONTAINER -n ROOT.war | xargs)
az rest --method PUT \
        --uri $SITE_URI \
        --body '{ 
            "properties": { 
                "properties": {
                    "packageUri": "'"${WAR_URL}"'"
                }, 
                "type": "war", 
                "ignorestack": false,
                "clean": true,
                "restart": false
            }
        }'

# Deploy database driver
az storage blob upload --account-name $STORAGE_ACCOUNT -c $CONTAINER -f setup/postgresql.jar
DRIVER_URL=$(az storage blob generate-sas --full-uri --permissions r --expiry $EXPIRY --account-name $STORAGE_ACCOUNT -c $CONTAINER -n postgresql.jar | xargs)
az rest --method PUT \
        --uri $SITE_URI \
        --body '{ 
            "properties": { 
                "properties": {
                    "packageUri": "'"${DRIVER_URL}"'"
                }, 
                "type": "lib", 
                "path": "/home/site/libs/postgresql.jar",
                "restart": false
            }
        }'

# Deploy JBoss scripts
az storage blob upload --account-name $STORAGE_ACCOUNT -c $CONTAINER -f setup/jboss-cli-commands.cli
SCRIPTS_URL=$(az storage blob generate-sas --full-uri --permissions r --expiry $EXPIRY --account-name $STORAGE_ACCOUNT -c $CONTAINER -n jboss-cli-commands.cli | xargs)
az rest --method PUT \
        --uri $SITE_URI \
        --body '{ 
            "properties": { 
                "properties": {
                    "packageUri": "'"${SCRIPTS_URL}"'"
                }, 
                "type": "lib", 
                "path": "/home/site/libs/jboss-cli-commands.cli",
                "restart": false
            }
        }'

# Deploy startup script
az storage blob upload --account-name $STORAGE_ACCOUNT -c $CONTAINER -f setup/startup.sh
STARTUP_URL=$(az storage blob generate-sas --full-uri --permissions r --expiry $EXPIRY --account-name $STORAGE_ACCOUNT -c $CONTAINER -n startup.sh | xargs)
az rest --method PUT \
        --uri $SITE_URI \
        --body '{ 
            "properties": { 
                "properties": {
                    "packageUri": "'"${STARTUP_URL}"'"
                }, 
                "type": "startup", 
                }
        }'
