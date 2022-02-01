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

// this deployment is including some examples to use 

// App Service Plan name should be unique within the resource group, opting for the simple 'name' property
resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: aznames.appServicePlan.name
  location: resourceGroup().location
  tags: tags
  sku: {
    name: 'F1'
    capacity: 1
  }
}

// Web application name should be globally unique, we prefer the 'nameUnique' property here
resource webApplication 'Microsoft.Web/sites@2018-11-01' = {
  name: aznames.appService.nameUnique
  location: location
  tags: union({
    'hidden-related:${resourceGroup().id}/providers/Microsoft.Web/serverfarms/${appServicePlan.name}': 'Resource'
  }, tags)
  properties: {
    serverFarmId: appServicePlan.id
  }
}

// Deploying a module, passing in the necessary naming parameters (storage account name should be also globally unique)
module storage 'modules/storage.module.bicep' = {
  name: 'StorageAccountDeployment'
  params: {
    location: location
    kind: 'StorageV2'
    skuName: 'Standard_LRS'
    name: aznames.storageAccount.nameUnique
    tags: tags
  }
}

output storageAccountName string = storage.outputs.name
output appServiceName string = webApplication.name
output appServicePlanName string = appServicePlan.name
