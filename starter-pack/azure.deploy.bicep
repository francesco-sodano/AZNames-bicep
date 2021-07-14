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

// Azure Names module Deployment - some parameters of this module should be fixed as part of the planned naming convention. 
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
output resourceGroupId string = rg.id
output resourceGroupName string = rg.name
output appServiceName string = main.outputs.appServiceName
output appServicePlanName string = main.outputs.appServicePlanName
output storageAccountName string = main.outputs.storageAccountName
