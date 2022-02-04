/*
 * AzNames Module - Starter Pack
 * This Bicep module helps to automate resource name generation following the recommended 
 * naming convention and abbreviations for Azure resource types.
 *
 * Authors: Francesco Sodano, Dominique Broeglin
 * Github: https://github.com/francesco-sodano/AZNames-bicep
 * 
 * Starter Pack Kit - Workload deployer
 */


param aznames object
param location string = resourceGroup().location
param tags object
param sqlAdmin string
param storageCount int
param dbsCount int


// Random password generation - don't use this in production environments
var sqlAdminPassword = 'B${uniqueString(resourceGroup().id)}!'

// this deployment is including some examples to use:

// EXAMPLE 1 - App Service Plan name should be unique within the resource group, opting for the simple 'refname' property
resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: aznames.appServicePlan.refName
  location: resourceGroup().location
  tags: tags
  sku: {
    name: 'F1'
    capacity: 1
  }
}

// EXAMPLE 2 - Web application name should be globally unique, we prefer the 'uniName' property here
resource webApplication 'Microsoft.Web/sites@2018-11-01' = {
  name: aznames.appService.uniName
  location: location
  tags: union({
    'hidden-related:${resourceGroup().id}/providers/Microsoft.Web/serverfarms/${appServicePlan.name}': 'Resource'
  }, tags)
  properties: {
    serverFarmId: appServicePlan.id
  }
}

// EXAMPLE 3 - Deploying a module, passing in the necessary naming parameters (storage account name should be also globally unique)
module storage 'modules/storage.module.bicep' = {
  name: 'StorageAccountDeployment'
  params: {
    location: location
    kind: 'StorageV2'
    skuName: 'Standard_LRS'
    name: aznames.storageAccount.uniName
    tags: tags
  }
}

// EXAMPLE 4 - Create multiple storage accounts instances with a loop using the 'unique' and appending the counter.
resource storageLoop 'Microsoft.Storage/storageAccounts@2021-06-01' = [for i in range(0, storageCount): {
  name: '${aznames.storageAccount.uniName}${i}'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    supportsHttpsTrafficOnly: true
  }
  tags: tags
}]

// EXAMPLE 5 - Create a SQL Server with multiple DBs using unique name for the server and refname with a counter for the DBs.
resource sql 'Microsoft.Sql/servers@2021-05-01-preview' = {
  name: aznames.sqlServer.uniName
  location: location
  properties: {
    administratorLogin: sqlAdmin
    administratorLoginPassword: sqlAdminPassword
    version: '12.0'
  }

  resource sqlDbsLoop 'databases@2021-05-01-preview' = [for i in range(0, dbsCount): {
    name: '${aznames.sqlDatabase.refName}-00${i}'
    location: location
    sku: {
      name: 'Basic'
    }
    properties: {}
    tags: tags
  }]
  tags: tags
}

output storageAccountName string = storage.outputs.name
output appServiceName string = webApplication.name
output appServicePlanName string = appServicePlan.name
output storageLoopNames array = [for i in range(0,storageCount) : {
  name: storageLoop[i].name
} ]
output sqlServerName string = sql.name
output sqlAdminPwd string = sqlAdminPassword
output sqlDbsLoopNames array = [for i in range(0,dbsCount) : {
  name: sql::sqlDbsLoop[i].name
} ]
