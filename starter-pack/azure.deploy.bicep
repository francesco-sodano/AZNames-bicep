/*
 * AzNames Module - Starter Pack
 * This Bicep module helps to automate resource name generation following the recommended 
 * naming convention and abbreviations for Azure resource types.
 *
 * Authors: Francesco Sodano, Dominique Broeglin
 * Github: https://github.com/francesco-sodano/AZNames-bicep
 * 
 * Starter Pack Kit - Umbrella deployment file
 */
targetScope = 'subscription'

param location string
param applicationName string
param environment string
param tags object = {}

// Resource group where the workload will be deployed
resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-${applicationName}-${environment}'
  location: location
  tags: tags
}

// AzNames module Deployment - some parameters of this module should be fixed as part of the planned naming convention.
// This will generate all the names of the resources at deployment time
module aznames 'modules/aznames.module.bicep' = {
  scope: resourceGroup(rg.name)
  name: 'azNames'  
  params: {
    suffixes: [
      applicationName
      environment
    ]
    uniquifierLength: 3
    uniquifier: rg.id
  }
}

// Main deployment has all the resources of the Workload (you can also refer here to extra resourcegroup or subscription resources)
// This will deploy all the resources getting, as input, the output of the AzNames module
module main 'workload.bicep' = {
  scope: resourceGroup(rg.name)
  name: 'workloadDeployment'
  params: {
    location: location
    aznames: aznames.outputs.names
    tags: tags
  }
}

// Outputs of the main deployment
// This section should be changed with the output of the deployment (or removed if not required)
output resourceGroupId string = rg.id
output resourceGroupName string = rg.name
output appServiceName string = main.outputs.appServiceName
output appServicePlanName string = main.outputs.appServicePlanName
output storageAccountName string = main.outputs.storageAccountName
output storageLoopNames array = main.outputs.storageLoopNames
