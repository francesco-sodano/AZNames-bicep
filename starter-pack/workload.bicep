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
param storageCount int = 3

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

// EXAMPLE 2 - Web application name should be globally unique, we prefer the 'nameUnique' property here
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

// EXAMPLE 4 - Create multiple storage accounts instances with a loop using the 'refName' and appending the counter.
resource storageLoop 'Microsoft.Storage/storageAccounts@2021-06-01' = [for i in range(0, storageCount): {
  name: '${aznames.storageAccount.refname}${i}'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  tags: tags
}]


output storageAccountName string = storage.outputs.name
output appServiceName string = webApplication.name
output appServicePlanName string = appServicePlan.name
output storageLoopNames array = [for i in range(0,storageCount) : {
  name: storageLoop[i].name
} ]
