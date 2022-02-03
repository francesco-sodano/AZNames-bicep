[![made-for-VSCode](https://img.shields.io/badge/Made%20for-VSCode-1f425f.svg)](https://code.visualstudio.com/)
[![Open in Visual Studio Code](https://open.vscode.dev/badges/open-in-vscode.svg)](https://open.vscode.dev/francesco-sodano/bicep-azurenaming) 


# AzNames - A Bicep module for a consistent naming convention in Azure

## Introduction

This Bicep module helps to automate resource name generation following the [recommended naming convention and abbreviations](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming)  for Azure resource types.

This module is made to be fully customizable and adapt to user defined naming convention (including custom resource abbreviation) and it's aim to support the user in any name generation requirements providing not only a unique name specific for the current deployment but also additional support output to be manipulated in the bicep main deployment.

Inspired by [Terraform module/implementation](https://github.com/Azure/terraform-azurerm-naming), this project is a reworking of the great job done by [Nikolaos Antoniou](https://github.com/nianton/azure-naming)


## Project Structure (and automation)

The base of the project is the `azure.resources.definition.json` file.
This JON file should be considered as the configuration file and contains all the rules for the name generation. The file is composed by multiple blocks (one for each resource) with the following structure:

```json
{
    "name": "app_service",
    "length": {
        "min": 2,
        "max": 60
    },
    "regex": "^(?=.{2,60}$)[a-z0-9][a-zA-Z0-9-]+[a-z0-9]",
    "scope": "global",
    "prefix": "app",
    "dashes": true
}
```
The attribute meanings are the following:

| Attribute | Description | 
| -------- | ---------- | 
| **name** | Name of the resource, this will be used as name for the resource call in the module without "_" | 
| **length** | The minimum and the maximum length of the resource name | 
| **regex** | Name regex rules for the resource|
| **scope** | Azure scope of the name unicity (could be Global, Subscription, Resource Group) |
| **prefix** | Defined prefix assigned to the resource |
| **dashes** | If the name accepts dash (-) in the name |

Most of this information can be taken from [the official Microsoft Documentation](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules#microsoftweb)


## The AzNames Module

Due to the fact that the names of the resources has to be known at compile-time, the only way to have this is to pre-populate an object with all the possible resource names and provide it as parameter to the bicep file deploying the workload. Due to this, we need to have a subscription-level deployment as entry-point.

for this reason, we have the `azure.deploy.bicep` (subscription-level deployment) that includes the `aznames.module.bicep` and pass the output (the object including all the names) to the `workload.bicep` that contains all the required Azure resources for the solution. 

### Input Parameters

| Parameter | Description | Type | Default | Required |
| -------- | ---------- | ----------- | ----------- | ----------- |
| **suffix** | Suffix parts to be included in the naming | array(string) | [appdemo,dev] | no |
| **uniquifier** | The string be used as uniquifuer | string | resourceGroup().id | no |
| **uniquifierLength** | The number of characters in the unique part | int | 3 | no |
| **useDashes** | Use dash (-) as delimiter | bool | true | no |

**Note**: the module doesn't support prefix as this is not recommended. if you need to add a prefix, like company name or azure region, you can add that manually or just reference them as tags or at higher level like subscription or management group.

### Output

| Property | Description | Type | 
| -------- | ---------- | ----------- |
| **refName** | the reference name without the uniquifier - useful for loops and resourcegroup scoped resources | string |
| **uniName** | the unique name including the uniquifier | string | 
| **prefix** | The prefix of the resources for your own name creating | string |
| **maxLength** | Max number of characters for the resource | int |
| **scope** | scope level where the name must be unique| string |
| **dashes** | if you can use dashes in the name | bool |

Every resource will have an output with the following format:

```go
appService = {
    refName = "app-suffix1-suffixN"
    uniName = "app-suffix1-suffixN-uniquifier"
    prefix = "app"
    maxLength = 60
    scope = "global"
    dashes = true
}
```

## How to use the Starter Pack

A Starter-Pack tool has been created to showcase how to use this module and how to create the required bicep file structure to safely deploy any workload. You will find it in the `starter-pack` folder of this repository.

The starter pack will create a resource group with the following Azure service instances:

- 1 Azure Webapp 
- 1 Azure App Service Plan
- 1 Azure Storage Account (deployed using a separate bicep module)
- 3 Azure Storage Accounts (deplyoed using a bicep loop)



### Deploy using Azure CLI

1. Open the Azure CLI directly from the Azure Portal
2. Clone the repository

    ```
    git clone https://github.com/francesco-sodano/AZNames-bicep
    ```

3. Move to the starter-pack folder.

    ```
    cd AZNames-bicep/starter-pack
    ```

4. Deploy the bicep main file

    ```
    az deployment sub create --location "West Europe" --template-file ./azure.deploy.bicep --parameters @azure.deploy.parameters.json
    ```

### Clean up

Don't forget to cleanup afterward to avoid any unnecessary costs:

    az group delete --resource-group rg-demobicep-prod


## Contributing

This project welcomes contributions and suggestions. Most contributions require you to agree to a Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us the rights to use your contribution. For details, visit https://cla.opensource.microsoft.com.

*TBD - prepare the GitHub customer template for issues to include additional resources*

### Building the module

Install the EPS templating module:

    Install-Module EPS

Then run the PowerShell script: 

    ./scripts/Invoke-AzNamesTemplate.ps1 > ./starter-pack/modules/aznames.module.bicep

## References

- [Azure Best Practices - Resource Naming](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming)
- [Azure Best Practices - Resource Abbreviations](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations)
- [Azure Resource Management - Resource Name Rules](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules)
- [GitHub - Azure Bicep](https://github.com/Azure/bicep/)
- [GitHub - Azure Naming for Terraform](https://github.com/Azure/terraform-azurerm-naming)
- [GitHub - Azure Naming for Bicep/ARM by Nikolaos Antoniou](https://github.com/nianton/azure-naming)
