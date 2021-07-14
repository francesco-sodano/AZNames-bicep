[![made-for-VSCode](https://img.shields.io/badge/Made%20for-VSCode-1f425f.svg)](https://code.visualstudio.com/)
[![Open in Visual Studio Code](https://open.vscode.dev/badges/open-in-vscode.svg)](https://open.vscode.dev/francesco-sodano/bicep-azurenaming) 


# AzNaming - A Bicep module for consistent naming convention in Azure

## Introduction

this is a bicep module to automate resource name generation following the recommended naming convention and abbreviations for Azure resource types
Bicep and ARM template module for keeping a consistent Azure resources naming convention, as well as respecting the rules for each resource name (max length, whether dashes are allowed etc). Inspired and based on the nice [Terraform module/implementation](https://github.com/Azure/terraform-azurerm-naming).

## Project Structure (and automation)

TBD

The resources are automatically generated using `go` to change the generation please change the file on the `templates` folder. To add a new resource, including its definition in the file `resourceDefinition.json`, and it will be automatically generated when `main.go` is run.

## The AzNaming Module

As in bicep the 'name' property of the resources to be created has to be know compile-time, the naming module cannot be directly consumed to name a resource but only as parameter to a module, we are resorting to have a subscription-level deployment azure.deploy.bicep which is passing as input parameter to the main.bicep deployment the naming part.

The main deployment is handled by the main.bicep file, which dictates the resources to be created within the created resource group and is responsible to consume the naming module as input.

### Input Parameters

| Parameter name | Description | Type | Default | Required |
| -------- | ---------- | ----------- | ----------- | ----------- |
| **suffix** | Array of suffix parts to be included in the naming | array(string) | [appdemo,dev] | no |
| **uniquifier** | The string be used as the seed for | string | resourceGroup().id | no |
| **uniquifierLength** | The number of characters in the unique part | int | 3 | no |
| **useDashes** | Whether to use dash (-) as delimiter | bool | true | no |

**Note**: the module doesn't support prefix as this is not recommended. if you need to add a prefix, like company name or azure region, you can add that manually or just reference them as tags or in the subscription name.

### Output

| Property | Description | Type | 
| -------- | ---------- | ----------- |
| **refName** | the reference name without the uniquifier - useful for loops and resourcegroup scoped resources | string |
| **uniName** | the unique name including the uniquifier | string | 
| **prefix** | The prefix of the resources for your own name creating | string |
| **maxLenght** | Max number of characters for the resource | int |
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


## How to use

A template sample repository was created to showcase how to use this module, and you will also find an example in the **`/examples`** folder, with the **`example.sub.bicep`** demonstrating how to use this module to facilitate naming resources on Azure.

## Contributing

This project welcomes contributions and suggestions. Most contributions require you to agree to a Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us the rights to use your contribution. For details, visit https://cla.opensource.microsoft.com.

## References

Bicep is a Domain Specific Language (DSL) for deploying Azure resources declaratively. It aims to drastically simplify the authoring experience with a cleaner syntax, improved type safety, and better support for modularity and code re-use. Bicep is a **transparent abstraction** over ARM and ARM templates, which means anything that can be done in an ARM Template can be done in Bicep (outside of temporary [known limitations](#known-limitations)). All resource `types`, `apiVersions`, and `properties` that are valid in an ARM template are equally valid in Bicep on day one (Note: even if Bicep warns that type information is not available for a resource, it can still be deployed).

- [Azure Best Practices - Resource Naming](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming)
- [Azure Best Practices - Resource Abbreviations](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations)
- [Azure Resource Management - Resource Name Rules](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules)
- [GitHub - Azure Bicep](https://github.com/Azure/bicep/)
- [GitHub - Azure Naming for Terraform](https://github.com/Azure/terraform-azurerm-naming)
- [GitHub - Azure Naming for Bicep/ARM by Nikolaos Antoniou](https://github.com/nianton/azure-naming)
