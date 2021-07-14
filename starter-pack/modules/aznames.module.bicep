/*
 * Azure Bicep Module:
 * Azure Naming Convention - Azure Resoruce refName Generator
 *
 * Author: Francesco Sodano
 * Github: https://github.com/francesco-sodano/bicep-azurenaming
 * 
 */

@description('suffixes for naming - if not specified, the names will refer to an APPDEMO application in a DEV environment')
param suffixes array = [
  'appdemo'
  'dev'
]

@description('Custom ending value for naming - if not specified, part of resourceGroup.Id will be used')
param uniquifier string = resourceGroup().id
 
@description('Max length of the uniqueness suffix to be added from 0 to 5 - if not specified, the lenght will be 3')
@minValue(0)
@maxValue(5)
param uniquifierLength int = 3
 
@description('Dashes will be used when possible')
param useDashes bool = true
 

var separator = useDashes ? '-' : ''
var useUniquifier = uniquifierLength == 0
var azureDummyResource = '????'
var definedSuffix = toLower('${separator}${replace(replace(replace(string(suffixes), '["', ''), '"]', ''), '","', separator)}')
var uniquifierEnd = useUniquifier ? '' : toLower('${separator}${substring(uniqueString(uniquifier), 0, uniquifierLength)}')

var resourceNameTemplate = '${azureDummyResource}${definedSuffix}'
var resourceNameTemplateNoDashes = replace(resourceNameTemplate, separator, '')
var uniqueResourceNameTemplate = '${azureDummyResource}${definedSuffix}${uniquifierEnd}'
var uniqueResourceNameTemplateNoDashes = replace(uniqueResourceNameTemplate, separator, '')

output names object = {
  analysisServicesServer: {
    refName: substring(replace(resourceNameTemplateNoDashes, separator, 'as'), 0, min(length(replace(resourceNameTemplateNoDashes, separator, 'as')), 63))
    uniName: substring(replace(uniqueResourceNameTemplateNoDashes, separator, 'as'), 0, min(length(replace(uniqueResourceNameTemplateNoDashes, separator, 'as')), 63))
    prefix: 'as'
    maxLenght: 63
    scope: 'resourceGroup'
    dashes: false
  }
  apiManagement: {
    refName: substring(replace(resourceNameTemplateNoDashes, separator, 'apim'), 0, min(length(replace(resourceNameTemplateNoDashes, separator, 'apim')), 50))
    uniName: substring(replace(uniqueResourceNameTemplateNoDashes, separator, 'apim'), 0, min(length(replace(uniqueResourceNameTemplateNoDashes, separator, 'apim')), 50))
    prefix: 'apim'
    maxLenght: 50
    scope: 'global'
    dashes: false
  }
  appConfiguration: {
    refName: substring(replace(resourceNameTemplate, separator, 'appcg'), 0, min(length(replace(resourceNameTemplate, separator, 'appcg')), 50))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'appcg'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'appcg')), 50))
    prefix: 'appcg'
    maxLenght: 50
    scope: 'resourceGroup'
    dashes: true
  }
  appServicePlan: {
    refName: substring(replace(resourceNameTemplate, separator, 'plan'), 0, min(length(replace(resourceNameTemplate, separator, 'plan')), 40))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'plan'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'plan')), 40))
    prefix: 'plan'
    maxLenght: 40
    scope: 'resourceGroup'
    dashes: true
  }
  appService: {
    refName: substring(replace(resourceNameTemplate, separator, 'app'), 0, min(length(replace(resourceNameTemplate, separator, 'app')), 60))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'app'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'app')), 60))
    prefix: 'app'
    maxLenght: 60
    scope: 'global'
    dashes: true
  }
  applicationGateway: {
    refName: substring(replace(resourceNameTemplate, separator, 'agw'), 0, min(length(replace(resourceNameTemplate, separator, 'agw')), 80))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'agw'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'agw')), 80))
    prefix: 'agw'
    maxLenght: 80
    scope: 'resourceGroup'
    dashes: true
  }
  applicationInsights: {
    refName: substring(replace(resourceNameTemplate, separator, 'appi'), 0, min(length(replace(resourceNameTemplate, separator, 'appi')), 260))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'appi'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'appi')), 260))
    prefix: 'appi'
    maxLenght: 260
    scope: 'resourceGroup'
    dashes: true
  }
  applicationSecurityGroup: {
    refName: substring(replace(resourceNameTemplate, separator, 'asg'), 0, min(length(replace(resourceNameTemplate, separator, 'asg')), 80))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'asg'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'asg')), 80))
    prefix: 'asg'
    maxLenght: 80
    scope: 'resourceGroup'
    dashes: true
  }
  automationAccount: {
    refName: substring(replace(resourceNameTemplate, separator, 'aa'), 0, min(length(replace(resourceNameTemplate, separator, 'aa')), 50))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'aa'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'aa')), 50))
    prefix: 'aa'
    maxLenght: 50
    scope: 'resourceGroup'
    dashes: true
  }
  automationCertificate: {
    refName: substring(replace(resourceNameTemplate, separator, 'aacert'), 0, min(length(replace(resourceNameTemplate, separator, 'aacert')), 128))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'aacert'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'aacert')), 128))
    prefix: 'aacert'
    maxLenght: 128
    scope: 'parent'
    dashes: true
  }
  automationCredential: {
    refName: substring(replace(resourceNameTemplate, separator, 'aacred'), 0, min(length(replace(resourceNameTemplate, separator, 'aacred')), 128))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'aacred'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'aacred')), 128))
    prefix: 'aacred'
    maxLenght: 128
    scope: 'parent'
    dashes: true
  }
  automationRunbook: {
    refName: substring(replace(resourceNameTemplate, separator, 'aacred'), 0, min(length(replace(resourceNameTemplate, separator, 'aacred')), 63))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'aacred'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'aacred')), 63))
    prefix: 'aacred'
    maxLenght: 63
    scope: 'parent'
    dashes: true
  }
  automationSchedule: {
    refName: substring(replace(resourceNameTemplate, separator, 'aasched'), 0, min(length(replace(resourceNameTemplate, separator, 'aasched')), 128))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'aasched'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'aasched')), 128))
    prefix: 'aasched'
    maxLenght: 128
    scope: 'parent'
    dashes: true
  }
  automationVariable: {
    refName: substring(replace(resourceNameTemplate, separator, 'aavar'), 0, min(length(replace(resourceNameTemplate, separator, 'aavar')), 128))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'aavar'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'aavar')), 128))
    prefix: 'aavar'
    maxLenght: 128
    scope: 'parent'
    dashes: true
  }
  availabilitySet: {
    refName: substring(replace(resourceNameTemplate, separator, 'avail'), 0, min(length(replace(resourceNameTemplate, separator, 'avail')), 80))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'avail'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'avail')), 80))
    prefix: 'avail'
    maxLenght: 80
    scope: 'resourceGroup'
    dashes: true
  }
  bastionHost: {
    refName: substring(replace(resourceNameTemplate, separator, 'snap'), 0, min(length(replace(resourceNameTemplate, separator, 'snap')), 80))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'snap'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'snap')), 80))
    prefix: 'bas'
    maxLenght: 80
    scope: 'resourceGroup'
    dashes: true
  }
  batchAccount: {
    refName: substring(replace(resourceNameTemplateNoDashes, separator, 'ba'), 0, min(length(replace(resourceNameTemplateNoDashes, separator, 'ba')), 24))
    uniName: substring(replace(uniqueResourceNameTemplateNoDashes, separator, 'ba'), 0, min(length(replace(uniqueResourceNameTemplateNoDashes, separator, 'ba')), 24))
    prefix: 'ba'
    maxLenght: 24
    scope: 'region'
    dashes: false
  }
  batchApplication: {
    refName: substring(replace(resourceNameTemplate, separator, 'baapp'), 0, min(length(replace(resourceNameTemplate, separator, 'baapp')), 64))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'baapp'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'baapp')), 64))
    prefix: 'baapp'
    maxLenght: 64
    scope: 'parent'
    dashes: true
  }
  batchCertificate: {
    refName: substring(replace(resourceNameTemplate, separator, 'bacert'), 0, min(length(replace(resourceNameTemplate, separator, 'bacert')), 45))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'bacert'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'bacert')), 45))
    prefix: 'bacert'
    maxLenght: 45
    scope: 'parent'
    dashes: true
  }
  batchPool: {
    refName: substring(replace(resourceNameTemplate, separator, 'bapool'), 0, min(length(replace(resourceNameTemplate, separator, 'bapool')), 24))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'bapool'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'bapool')), 24))
    prefix: 'bapool'
    maxLenght: 24
    scope: 'parent'
    dashes: true
  }
  cdnEndpoint: {
    refName: substring(replace(resourceNameTemplate, separator, 'cdn'), 0, min(length(replace(resourceNameTemplate, separator, 'cdn')), 50))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'cdn'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'cdn')), 50))
    prefix: 'cdn'
    maxLenght: 50
    scope: 'global'
    dashes: true
  }
  cdnProfile: {
    refName: substring(replace(resourceNameTemplate, separator, 'cdnprof'), 0, min(length(replace(resourceNameTemplate, separator, 'cdnprof')), 260))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'cdnprof'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'cdnprof')), 260))
    prefix: 'cdnprof'
    maxLenght: 260
    scope: 'resourceGroup'
    dashes: true
  }
  cognitiveService: {
    refName: substring(replace(resourceNameTemplate, separator, 'cog'), 0, min(length(replace(resourceNameTemplate, separator, 'cog')), 64))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'cog'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'cog')), 64))
    prefix: 'cog'
    maxLenght: 64
    scope: 'resourceGroup'
    dashes: true
  }
  containerGroup: {
    refName: substring(replace(resourceNameTemplate, separator, 'cg'), 0, min(length(replace(resourceNameTemplate, separator, 'cg')), 63))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'cg'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'cg')), 63))
    prefix: 'cg'
    maxLenght: 63
    scope: 'resourceGroup'
    dashes: true
  }
  containerRegistry: {
    refName: substring(replace(resourceNameTemplateNoDashes, separator, 'acr'), 0, min(length(replace(resourceNameTemplateNoDashes, separator, 'acr')), 63))
    uniName: substring(replace(uniqueResourceNameTemplateNoDashes, separator, 'acr'), 0, min(length(replace(uniqueResourceNameTemplateNoDashes, separator, 'acr')), 63))
    prefix: 'acr'
    maxLenght: 63
    scope: 'resourceGroup'
    dashes: false
  }
  containerRegistryWebhook: {
    refName: substring(replace(resourceNameTemplateNoDashes, separator, 'crwh'), 0, min(length(replace(resourceNameTemplateNoDashes, separator, 'crwh')), 50))
    uniName: substring(replace(uniqueResourceNameTemplateNoDashes, separator, 'crwh'), 0, min(length(replace(uniqueResourceNameTemplateNoDashes, separator, 'crwh')), 50))
    prefix: 'crwh'
    maxLenght: 50
    scope: 'resourceGroup'
    dashes: false
  }
  cosmosdbservice: {
    refName: substring(replace(resourceNameTemplate, separator, 'cosmos'), 0, min(length(replace(resourceNameTemplate, separator, 'cosmos')), 63))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'cosmos'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'cosmos')), 63))
    prefix: 'cosmos'
    maxLenght: 63
    scope: 'resourceGroup'
    dashes: true
  }
  customProvider: {
    refName: substring(replace(resourceNameTemplate, separator, 'prov'), 0, min(length(replace(resourceNameTemplate, separator, 'prov')), 64))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'prov'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'prov')), 64))
    prefix: 'prov'
    maxLenght: 64
    scope: 'resourceGroup'
    dashes: true
  }
  dashboard: {
    refName: substring(replace(resourceNameTemplate, separator, 'dsb'), 0, min(length(replace(resourceNameTemplate, separator, 'dsb')), 160))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'dsb'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'dsb')), 160))
    prefix: 'dsb'
    maxLenght: 160
    scope: 'parent'
    dashes: true
  }
  dataFactory: {
    refName: substring(replace(resourceNameTemplate, separator, 'adf'), 0, min(length(replace(resourceNameTemplate, separator, 'adf')), 63))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'adf'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'adf')), 63))
    prefix: 'adf'
    maxLenght: 63
    scope: 'global'
    dashes: true
  }
  dataFactoryDatasetMysql: {
    refName: substring(replace(resourceNameTemplate, separator, 'adfmysql'), 0, min(length(replace(resourceNameTemplate, separator, 'adfmysql')), 260))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'adfmysql'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'adfmysql')), 260))
    prefix: 'adfmysql'
    maxLenght: 260
    scope: 'parent'
    dashes: true
  }
  dataFactoryDatasetPostgresql: {
    refName: substring(replace(resourceNameTemplate, separator, 'adfpsql'), 0, min(length(replace(resourceNameTemplate, separator, 'adfpsql')), 260))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'adfpsql'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'adfpsql')), 260))
    prefix: 'adfpsql'
    maxLenght: 260
    scope: 'parent'
    dashes: true
  }
  dataFactoryDatasetSqlServerTable: {
    refName: substring(replace(resourceNameTemplate, separator, 'adfmssql'), 0, min(length(replace(resourceNameTemplate, separator, 'adfmssql')), 260))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'adfmssql'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'adfmssql')), 260))
    prefix: 'adfmssql'
    maxLenght: 260
    scope: 'parent'
    dashes: true
  }
  dataFactoryIntegrationRuntimeManaged: {
    refName: substring(replace(resourceNameTemplate, separator, 'adfir'), 0, min(length(replace(resourceNameTemplate, separator, 'adfir')), 63))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'adfir'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'adfir')), 63))
    prefix: 'adfir'
    maxLenght: 63
    scope: 'parent'
    dashes: true
  }
  dataFactoryLinkedServiceDataLakeStorageGen2: {
    refName: substring(replace(resourceNameTemplate, separator, 'adfsvst'), 0, min(length(replace(resourceNameTemplate, separator, 'adfsvst')), 260))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'adfsvst'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'adfsvst')), 260))
    prefix: 'adfsvst'
    maxLenght: 260
    scope: 'parent'
    dashes: true
  }
  dataFactoryLinkedServiceKeyVault: {
    refName: substring(replace(resourceNameTemplate, separator, 'adfsvkv'), 0, min(length(replace(resourceNameTemplate, separator, 'adfsvkv')), 260))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'adfsvkv'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'adfsvkv')), 260))
    prefix: 'adfsvkv'
    maxLenght: 260
    scope: 'parent'
    dashes: true
  }
  dataFactoryLinkedServiceMysql: {
    refName: substring(replace(resourceNameTemplate, separator, 'adfsvmysql'), 0, min(length(replace(resourceNameTemplate, separator, 'adfsvmysql')), 260))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'adfsvmysql'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'adfsvmysql')), 260))
    prefix: 'adfsvmysql'
    maxLenght: 260
    scope: 'parent'
    dashes: true
  }
  dataFactoryLinkedServicePostgresql: {
    refName: substring(replace(resourceNameTemplate, separator, 'adfsvpsql'), 0, min(length(replace(resourceNameTemplate, separator, 'adfsvpsql')), 260))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'adfsvpsql'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'adfsvpsql')), 260))
    prefix: 'adfsvpsql'
    maxLenght: 260
    scope: 'parent'
    dashes: true
  }
  dataFactoryLinkedServiceSqlServer: {
    refName: substring(replace(resourceNameTemplate, separator, 'adfsvmssql'), 0, min(length(replace(resourceNameTemplate, separator, 'adfsvmssql')), 260))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'adfsvmssql'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'adfsvmssql')), 260))
    prefix: 'adfsvmssql'
    maxLenght: 260
    scope: 'parent'
    dashes: true
  }
  dataFactoryPipeline: {
    refName: substring(replace(resourceNameTemplate, separator, 'adfpl'), 0, min(length(replace(resourceNameTemplate, separator, 'adfpl')), 260))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'adfpl'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'adfpl')), 260))
    prefix: 'adfpl'
    maxLenght: 260
    scope: 'parent'
    dashes: true
  }
  dataFactoryTriggerSchedule: {
    refName: substring(replace(resourceNameTemplate, separator, 'adftg'), 0, min(length(replace(resourceNameTemplate, separator, 'adftg')), 260))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'adftg'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'adftg')), 260))
    prefix: 'adftg'
    maxLenght: 260
    scope: 'parent'
    dashes: true
  }
  dataLakeAnalyticsAccount: {
    refName: substring(replace(resourceNameTemplateNoDashes, separator, 'dla'), 0, min(length(replace(resourceNameTemplateNoDashes, separator, 'dla')), 24))
    uniName: substring(replace(uniqueResourceNameTemplateNoDashes, separator, 'dla'), 0, min(length(replace(uniqueResourceNameTemplateNoDashes, separator, 'dla')), 24))
    prefix: 'dla'
    maxLenght: 24
    scope: 'global'
    dashes: false
  }
  dataLakeAnalyticsFirewallRule: {
    refName: substring(replace(resourceNameTemplate, separator, 'dlfw'), 0, min(length(replace(resourceNameTemplate, separator, 'dlfw')), 50))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'dlfw'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'dlfw')), 50))
    prefix: 'dlfw'
    maxLenght: 50
    scope: 'parent'
    dashes: true
  }
  dataLakeStorage: {
    refName: substring(replace(resourceNameTemplateNoDashes, separator, 'dls'), 0, min(length(replace(resourceNameTemplateNoDashes, separator, 'dls')), 24))
    uniName: substring(replace(uniqueResourceNameTemplateNoDashes, separator, 'dls'), 0, min(length(replace(uniqueResourceNameTemplateNoDashes, separator, 'dls')), 24))
    prefix: 'dls'
    maxLenght: 24
    scope: 'parent'
    dashes: true
  }
  dataLakeStorageFirewallRule: {
    refName: substring(replace(resourceNameTemplate, separator, 'dlsfw'), 0, min(length(replace(resourceNameTemplate, separator, 'dlsfw')), 50))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'dlsfw'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'dlsfw')), 50))
    prefix: 'dlsfw'
    maxLenght: 50
    scope: 'parent'
    dashes: true
  }
  databricksWorkspace: {
    refName: substring(replace(resourceNameTemplate, separator, 'dbw'), 0, min(length(replace(resourceNameTemplate, separator, 'dbw')), 30))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'dbw'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'dbw')), 30))
    prefix: 'dbw'
    maxLenght: 30
    scope: 'resourceGroup'
    dashes: true
  }
  diskEncryptionSet: {
    refName: substring(replace(resourceNameTemplate, separator, 'des'), 0, min(length(replace(resourceNameTemplate, separator, 'des')), 80))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'des'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'des')), 80))
    prefix: 'des'
    maxLenght: 80
    scope: 'resourceGroup'
    dashes: true
  }
  dnsZone: {
    refName: substring(replace(resourceNameTemplate, separator, 'dns'), 0, min(length(replace(resourceNameTemplate, separator, 'dns')), 63))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'dns'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'dns')), 63))
    prefix: 'dns'
    maxLenght: 63
    scope: 'resourceGroup'
    dashes: true
  }
  eventGridDomain: {
    refName: substring(replace(resourceNameTemplate, separator, 'egd'), 0, min(length(replace(resourceNameTemplate, separator, 'egd')), 50))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'egd'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'egd')), 50))
    prefix: 'egd'
    maxLenght: 50
    scope: 'resourceGroup'
    dashes: true
  }
  eventGridDomainTopic: {
    refName: substring(replace(resourceNameTemplate, separator, 'egdt'), 0, min(length(replace(resourceNameTemplate, separator, 'egdt')), 50))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'egdt'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'egdt')), 50))
    prefix: 'egdt'
    maxLenght: 50
    scope: 'parent'
    dashes: true
  }
  eventGridEventSubscription: {
    refName: substring(replace(resourceNameTemplate, separator, 'egs'), 0, min(length(replace(resourceNameTemplate, separator, 'egs')), 64))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'egs'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'egs')), 64))
    prefix: 'egs'
    maxLenght: 64
    scope: 'resourceGroup'
    dashes: true
  }
  eventGridTopic: {
    refName: substring(replace(resourceNameTemplate, separator, 'egt'), 0, min(length(replace(resourceNameTemplate, separator, 'egt')), 50))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'egt'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'egt')), 50))
    prefix: 'egt'
    maxLenght: 50
    scope: 'resourceGroup'
    dashes: true
  }
  eventHub: {
    refName: substring(replace(resourceNameTemplate, separator, 'evh'), 0, min(length(replace(resourceNameTemplate, separator, 'evh')), 50))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'evh'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'evh')), 50))
    prefix: 'evh'
    maxLenght: 50
    scope: 'parent'
    dashes: true
  }
  eventHubAuthorizationRule: {
    refName: substring(replace(resourceNameTemplate, separator, 'evhar'), 0, min(length(replace(resourceNameTemplate, separator, 'evhar')), 50))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'evhar'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'evhar')), 50))
    prefix: 'evhar'
    maxLenght: 50
    scope: 'parent'
    dashes: true
  }
  eventHubConsumerGroup: {
    refName: substring(replace(resourceNameTemplate, separator, 'evhcg'), 0, min(length(replace(resourceNameTemplate, separator, 'evhcg')), 50))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'evhcg'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'evhcg')), 50))
    prefix: 'evhcg'
    maxLenght: 50
    scope: 'parent'
    dashes: true
  }
  eventHubNamespace: {
    refName: substring(replace(resourceNameTemplate, separator, 'evhn'), 0, min(length(replace(resourceNameTemplate, separator, 'evhn')), 50))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'evhn'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'evhn')), 50))
    prefix: 'evhns'
    maxLenght: 50
    scope: 'global'
    dashes: true
  }
  eventHubNamespaceAuthorizationRule: {
    refName: substring(replace(resourceNameTemplate, separator, 'evhnar'), 0, min(length(replace(resourceNameTemplate, separator, 'evhnar')), 50))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'evhnar'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'evhnar')), 50))
    prefix: 'evhnar'
    maxLenght: 50
    scope: 'parent'
    dashes: true
  }
  eventHubNamespaceDisasterRecoveryConfig: {
    refName: substring(replace(resourceNameTemplate, separator, 'evhdr'), 0, min(length(replace(resourceNameTemplate, separator, 'evhdr')), 50))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'evhdr'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'evhdr')), 50))
    prefix: 'evhdr'
    maxLenght: 50
    scope: 'parent'
    dashes: true
  }
  expressRouteCircuit: {
    refName: substring(replace(resourceNameTemplate, separator, 'erc'), 0, min(length(replace(resourceNameTemplate, separator, 'erc')), 80))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'erc'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'erc')), 80))
    prefix: 'erc'
    maxLenght: 80
    scope: 'resourceGroup'
    dashes: true
  }
  expressRouteGateway: {
    refName: substring(replace(resourceNameTemplate, separator, 'ergw'), 0, min(length(replace(resourceNameTemplate, separator, 'ergw')), 80))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'ergw'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'ergw')), 80))
    prefix: 'ergw'
    maxLenght: 80
    scope: 'resourceGroup'
    dashes: true
  }
  firewall: {
    refName: substring(replace(resourceNameTemplate, separator, 'afw'), 0, min(length(replace(resourceNameTemplate, separator, 'afw')), 80))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'afw'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'afw')), 80))
    prefix: 'afw'
    maxLenght: 80
    scope: 'resourceGroup'
    dashes: true
  }
  firewallPolicy: {
    refName: substring(replace(resourceNameTemplate, separator, 'afw'), 0, min(length(replace(resourceNameTemplate, separator, 'afw')), 80))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'afw'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'afw')), 80))
    prefix: 'afwp'
    maxLenght: 80
    scope: 'resourceGroup'
    dashes: true
  }
  frontDoor: {
    refName: substring(replace(resourceNameTemplate, separator, 'fd'), 0, min(length(replace(resourceNameTemplate, separator, 'fd')), 64))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'fd'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'fd')), 64))
    prefix: 'fd'
    maxLenght: 64
    scope: 'global'
    dashes: true
  }
  frontDoorFirewallPolicy: {
    refName: substring(replace(resourceNameTemplate, separator, 'fdfp'), 0, min(length(replace(resourceNameTemplate, separator, 'fdfp')), 80))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'fdfp'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'fdfp')), 80))
    prefix: 'fdfp'
    maxLenght: 80
    scope: 'global'
    dashes: true
  }
  functionApp: {
    refName: substring(replace(resourceNameTemplate, separator, 'func'), 0, min(length(replace(resourceNameTemplate, separator, 'func')), 60))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'func'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'func')), 60))
    prefix: 'func'
    maxLenght: 60
    scope: 'global'
    dashes: true
  }
  hdInsightHadoopCluster: {
    refName: substring(replace(resourceNameTemplate, separator, 'hadoop'), 0, min(length(replace(resourceNameTemplate, separator, 'hadoop')), 59))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'hadoop'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'hadoop')), 59))
    prefix: 'hadoop'
    maxLenght: 59
    scope: 'global'
    dashes: true
  }
  hdInsightHbaseCluster: {
    refName: substring(replace(resourceNameTemplate, separator, 'hbase'), 0, min(length(replace(resourceNameTemplate, separator, 'hbase')), 59))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'hbase'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'hbase')), 59))
    prefix: 'hbase'
    maxLenght: 59
    scope: 'global'
    dashes: true
  }
  hdInsightInteractiveQueryCluster: {
    refName: substring(replace(resourceNameTemplate, separator, 'iqr'), 0, min(length(replace(resourceNameTemplate, separator, 'iqr')), 59))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'iqr'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'iqr')), 59))
    prefix: 'iqr'
    maxLenght: 59
    scope: 'global'
    dashes: true
  }
  hdInsightKafkaCluster: {
    refName: substring(replace(resourceNameTemplate, separator, 'kafka'), 0, min(length(replace(resourceNameTemplate, separator, 'kafka')), 59))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'kafka'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'kafka')), 59))
    prefix: 'kafka'
    maxLenght: 59
    scope: 'global'
    dashes: true
  }
  hdInsightMlServicesCluster: {
    refName: substring(replace(resourceNameTemplate, separator, 'mls'), 0, min(length(replace(resourceNameTemplate, separator, 'mls')), 59))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'mls'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'mls')), 59))
    prefix: 'mls'
    maxLenght: 59
    scope: 'global'
    dashes: true
  }
  hdInsightRserverCluster: {
    refName: substring(replace(resourceNameTemplate, separator, 'rsv'), 0, min(length(replace(resourceNameTemplate, separator, 'rsv')), 59))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'rsv'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'rsv')), 59))
    prefix: 'rsv'
    maxLenght: 59
    scope: 'global'
    dashes: true
  }
  hdInsightSparkCluster: {
    refName: substring(replace(resourceNameTemplate, separator, 'spark'), 0, min(length(replace(resourceNameTemplate, separator, 'spark')), 59))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'spark'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'spark')), 59))
    prefix: 'spark'
    maxLenght: 59
    scope: 'global'
    dashes: true
  }
  hdInsightStormCluster: {
    refName: substring(replace(resourceNameTemplate, separator, 'storm'), 0, min(length(replace(resourceNameTemplate, separator, 'storm')), 59))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'storm'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'storm')), 59))
    prefix: 'storm'
    maxLenght: 59
    scope: 'global'
    dashes: true
  }
  image: {
    refName: substring(replace(resourceNameTemplate, separator, 'img'), 0, min(length(replace(resourceNameTemplate, separator, 'img')), 80))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'img'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'img')), 80))
    prefix: 'img'
    maxLenght: 80
    scope: 'resourceGroup'
    dashes: true
  }
  iotCentralApplication: {
    refName: substring(replace(resourceNameTemplate, separator, 'iotapp'), 0, min(length(replace(resourceNameTemplate, separator, 'iotapp')), 63))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'iotapp'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'iotapp')), 63))
    prefix: 'iotapp'
    maxLenght: 63
    scope: 'global'
    dashes: true
  }
  iotHub: {
    refName: substring(replace(resourceNameTemplate, separator, 'iot'), 0, min(length(replace(resourceNameTemplate, separator, 'iot')), 50))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'iot'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'iot')), 50))
    prefix: 'iot'
    maxLenght: 50
    scope: 'global'
    dashes: true
  }
  iotHubConsumerGroup: {
    refName: substring(replace(resourceNameTemplate, separator, 'iotcg'), 0, min(length(replace(resourceNameTemplate, separator, 'iotcg')), 50))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'iotcg'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'iotcg')), 50))
    prefix: 'iotcg'
    maxLenght: 50
    scope: 'parent'
    dashes: true
  }
  iotHubProvisioningService: {
    refName: substring(replace(resourceNameTemplate, separator, 'provs'), 0, min(length(replace(resourceNameTemplate, separator, 'provs')), 64))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'provs'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'provs')), 64))
    prefix: 'provs'
    maxLenght: 64
    scope: 'resourceGroup'
    dashes: true
  }
  iotHubDpsCertificate: {
    refName: substring(replace(resourceNameTemplate, separator, 'pcert'), 0, min(length(replace(resourceNameTemplate, separator, 'pcert')), 64))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'pcert'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'pcert')), 64))
    prefix: 'pcert'
    maxLenght: 64
    scope: 'parent'
    dashes: true
  }
  keyVault: {
    refName: substring(replace(resourceNameTemplate, separator, 'kv'), 0, min(length(replace(resourceNameTemplate, separator, 'kv')), 24))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'kv'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'kv')), 24))
    prefix: 'kv'
    maxLenght: 24
    scope: 'global'
    dashes: true
  }
  keyVaultCertificate: {
    refName: substring(replace(resourceNameTemplate, separator, 'kvc'), 0, min(length(replace(resourceNameTemplate, separator, 'kvc')), 127))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'kvc'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'kvc')), 127))
    prefix: 'kvc'
    maxLenght: 127
    scope: 'parent'
    dashes: true
  }
  keyVaultKey: {
    refName: substring(replace(resourceNameTemplate, separator, 'kvk'), 0, min(length(replace(resourceNameTemplate, separator, 'kvk')), 127))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'kvk'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'kvk')), 127))
    prefix: 'kvk'
    maxLenght: 127
    scope: 'parent'
    dashes: true
  }
  keyVaultSecret: {
    refName: substring(replace(resourceNameTemplate, separator, 'kvs'), 0, min(length(replace(resourceNameTemplate, separator, 'kvs')), 127))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'kvs'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'kvs')), 127))
    prefix: 'kvs'
    maxLenght: 127
    scope: 'parent'
    dashes: true
  }
  kubernetesCluster: {
    refName: substring(replace(resourceNameTemplate, separator, 'aks'), 0, min(length(replace(resourceNameTemplate, separator, 'aks')), 63))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'aks'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'aks')), 63))
    prefix: 'aks'
    maxLenght: 63
    scope: 'resourceGroup'
    dashes: true
  }
  kustoCluster: {
    refName: substring(replace(resourceNameTemplateNoDashes, separator, 'kc'), 0, min(length(replace(resourceNameTemplateNoDashes, separator, 'kc')), 22))
    uniName: substring(replace(uniqueResourceNameTemplateNoDashes, separator, 'kc'), 0, min(length(replace(uniqueResourceNameTemplateNoDashes, separator, 'kc')), 22))
    prefix: 'kc'
    maxLenght: 22
    scope: 'global'
    dashes: false
  }
  kustoDatabase: {
    refName: substring(replace(resourceNameTemplate, separator, 'kdb'), 0, min(length(replace(resourceNameTemplate, separator, 'kdb')), 260))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'kdb'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'kdb')), 260))
    prefix: 'kdb'
    maxLenght: 260
    scope: 'parent'
    dashes: true
  }
  kustoEventHubDataConnection: {
    refName: substring(replace(resourceNameTemplate, separator, 'kehc'), 0, min(length(replace(resourceNameTemplate, separator, 'kehc')), 40))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'kehc'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'kehc')), 40))
    prefix: 'kehc'
    maxLenght: 40
    scope: 'parent'
    dashes: true
  }
  loadBalancer: {
    refName: substring(replace(resourceNameTemplate, separator, 'lb'), 0, min(length(replace(resourceNameTemplate, separator, 'lb')), 80))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'lb'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'lb')), 80))
    prefix: 'lb'
    maxLenght: 80
    scope: 'resourceGroup'
    dashes: true
  }
  loadBalancerNatRule: {
    refName: substring(replace(resourceNameTemplate, separator, 'lbnatrl'), 0, min(length(replace(resourceNameTemplate, separator, 'lbnatrl')), 80))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'lbnatrl'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'lbnatrl')), 80))
    prefix: 'lbnatrl'
    maxLenght: 80
    scope: 'parent'
    dashes: true
  }
  localNetworkGateway: {
    refName: substring(replace(resourceNameTemplate, separator, 'lgw'), 0, min(length(replace(resourceNameTemplate, separator, 'lgw')), 80))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'lgw'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'lgw')), 80))
    prefix: 'lgw'
    maxLenght: 80
    scope: 'resourceGroup'
    dashes: true
  }
  logAnalyticsWorkspace: {
    refName: substring(replace(resourceNameTemplate, separator, 'log'), 0, min(length(replace(resourceNameTemplate, separator, 'log')), 63))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'log'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'log')), 63))
    prefix: 'log'
    maxLenght: 63
    scope: 'parent'
    dashes: true
  }
  logicApp: {
    refName: substring(replace(resourceNameTemplate, separator, 'logic'), 0, min(length(replace(resourceNameTemplate, separator, 'logic')), 80))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'logic'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'logic')), 80))
    prefix: 'logic'
    maxLenght: 80
    scope: 'resourceGroup'
    dashes: true
  }  
  machineLearningWorkspace: {
    refName: substring(replace(resourceNameTemplate, separator, 'mlw'), 0, min(length(replace(resourceNameTemplate, separator, 'mlw')), 260))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'mlw'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'mlw')), 260))
    prefix: 'mlw'
    maxLenght: 260
    scope: 'resourceGroup'
    dashes: true
  }
  managedDisk: {
    refName: substring(replace(resourceNameTemplate, separator, 'dsk'), 0, min(length(replace(resourceNameTemplate, separator, 'dsk')), 80))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'dsk'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'dsk')), 80))
    prefix: 'dsk'
    maxLenght: 80
    scope: 'resourceGroup'
    dashes: true
  }
  mapsService: {
    refName: substring(replace(resourceNameTemplate, separator, 'map'), 0, min(length(replace(resourceNameTemplate, separator, 'map')), 98))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'map'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'map')), 98))
    prefix: 'map'
    maxLenght: 98
    scope: 'resourceGroup'
    dashes: true
  }
  mariadbDatabase: {
    refName: substring(replace(resourceNameTemplate, separator, 'mariadb'), 0, min(length(replace(resourceNameTemplate, separator, 'mariadb')), 63))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'mariadb'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'mariadb')), 63))
    prefix: 'mariadb'
    maxLenght: 63
    scope: 'parent'
    dashes: true
  }
  mariadbFirewallRule: {
    refName: substring(replace(resourceNameTemplate, separator, 'mariafw'), 0, min(length(replace(resourceNameTemplate, separator, 'mariafw')), 128))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'mariafw'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'mariafw')), 128))
    prefix: 'mariafw'
    maxLenght: 128
    scope: 'parent'
    dashes: true
  }
  mariadbServer: {
    refName: substring(replace(resourceNameTemplate, separator, 'maria'), 0, min(length(replace(resourceNameTemplate, separator, 'maria')), 63))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'maria'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'maria')), 63))
    prefix: 'maria'
    maxLenght: 63
    scope: 'global'
    dashes: true
  }
  mariadbVirtualNetworkRule: {
    refName: substring(replace(resourceNameTemplate, separator, 'mariavn'), 0, min(length(replace(resourceNameTemplate, separator, 'mariavn')), 128))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'mariavn'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'mariavn')), 128))
    prefix: 'mariavn'
    maxLenght: 128
    scope: 'parent'
    dashes: true
  }
  mysqlDatabase: {
    refName: substring(replace(resourceNameTemplate, separator, 'mysqldb'), 0, min(length(replace(resourceNameTemplate, separator, 'mysqldb')), 63))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'mysqldb'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'mysqldb')), 63))
    prefix: 'mysqldb'
    maxLenght: 63
    scope: 'parent'
    dashes: true
  }
  mysqlFirewallRule: {
    refName: substring(replace(resourceNameTemplate, separator, 'mysqlfw'), 0, min(length(replace(resourceNameTemplate, separator, 'mysqlfw')), 128))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'mysqlfw'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'mysqlfw')), 128))
    prefix: 'mysqlfw'
    maxLenght: 128
    scope: 'parent'
    dashes: true
  }
  mysqlServer: {
    refName: substring(replace(resourceNameTemplate, separator, 'mysql'), 0, min(length(replace(resourceNameTemplate, separator, 'mysql')), 63))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'mysql'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'mysql')), 63))
    prefix: 'mysql'
    maxLenght: 63
    scope: 'global'
    dashes: true
  }
  mysqlVirtualNetworkRule: {
    refName: substring(replace(resourceNameTemplate, separator, 'mysqlvn'), 0, min(length(replace(resourceNameTemplate, separator, 'mysqlvn')), 128))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'mysqlvn'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'mysqlvn')), 128))
    prefix: 'mysqlvn'
    maxLenght: 128
    scope: 'parent'
    dashes: true
  }
  networkInterface: {
    refName: substring(replace(resourceNameTemplate, separator, 'nic'), 0, min(length(replace(resourceNameTemplate, separator, 'nic')), 80))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'nic'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'nic')), 80))
    prefix: 'nic'
    maxLenght: 80
    scope: 'resourceGroup'
    dashes: true
  }
  networkSecurityGroup: {
    refName: substring(replace(resourceNameTemplate, separator, 'nsg'), 0, min(length(replace(resourceNameTemplate, separator, 'nsg')), 80))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'nsg'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'nsg')), 80))
    prefix: 'nsg'
    maxLenght: 80
    scope: 'resourceGroup'
    dashes: true
  }
  networkSecurityGroupRule: {
    refName: substring(replace(resourceNameTemplate, separator, 'nsgr'), 0, min(length(replace(resourceNameTemplate, separator, 'nsgr')), 80))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'nsgr'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'nsgr')), 80))
    prefix: 'nsgr'
    maxLenght: 80
    scope: 'parent'
    dashes: true
  }
  networkWatcher: {
    refName: substring(replace(resourceNameTemplate, separator, 'nw'), 0, min(length(replace(resourceNameTemplate, separator, 'nw')), 80))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'nw'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'nw')), 80))
    prefix: 'nw'
    maxLenght: 80
    scope: 'resourceGroup'
    dashes: true
  }
  notificationHub: {
    refName: substring(replace(resourceNameTemplate, separator, 'ntf'), 0, min(length(replace(resourceNameTemplate, separator, 'ntf')), 260))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'ntf'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'ntf')), 260))
    prefix: 'ntf'
    maxLenght: 260
    scope: 'parent'
    dashes: true
  }
  notificationHubAuthorizationRule: {
    refName: substring(replace(resourceNameTemplate, separator, 'ntfr'), 0, min(length(replace(resourceNameTemplate, separator, 'ntfr')), 256))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'ntfr'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'ntfr')), 256))
    prefix: 'ntfr'
    maxLenght: 256
    scope: 'parent'
    dashes: true
  }
  notificationHubNamespace: {
    refName: substring(replace(resourceNameTemplate, separator, 'ntfns'), 0, min(length(replace(resourceNameTemplate, separator, 'ntfns')), 50))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'ntfns'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'ntfns')), 50))
    prefix: 'ntfns'
    maxLenght: 50
    scope: 'global'
    dashes: true
  }
  postgresqlDatabase: {
    refName: substring(replace(resourceNameTemplate, separator, 'psqldb'), 0, min(length(replace(resourceNameTemplate, separator, 'psqldb')), 63))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'psqldb'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'psqldb')), 63))
    prefix: 'psqldb'
    maxLenght: 63
    scope: 'parent'
    dashes: true
  }
  postgresqlFirewallRule: {
    refName: substring(replace(resourceNameTemplate, separator, 'psqlfw'), 0, min(length(replace(resourceNameTemplate, separator, 'psqlfw')), 128))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'psqlfw'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'psqlfw')), 128))
    prefix: 'psqlfw'
    maxLenght: 128
    scope: 'parent'
    dashes: true
  }
  postgresqlServer: {
    refName: substring(replace(resourceNameTemplate, separator, 'psql'), 0, min(length(replace(resourceNameTemplate, separator, 'psql')), 63))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'psql'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'psql')), 63))
    prefix: 'psql'
    maxLenght: 63
    scope: 'global'
    dashes: true
  }
  postgresqlVirtualNetworkRule: {
    refName: substring(replace(resourceNameTemplate, separator, 'psqlvn'), 0, min(length(replace(resourceNameTemplate, separator, 'psqlvn')), 128))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'psqlvn'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'psqlvn')), 128))
    prefix: 'psqlvn'
    maxLenght: 128
    scope: 'parent'
    dashes: true
  }
  privateDnsZone: {
    refName: substring(replace(resourceNameTemplate, separator, 'pdnsz'), 0, min(length(replace(resourceNameTemplate, separator, 'pdnsz')), 63))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'pdnsz'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'pdnsz')), 63))
    prefix: 'pdnsz'
    maxLenght: 63
    scope: 'resourceGroup'
    dashes: true
  }
  publicIp: {
    refName: substring(replace(resourceNameTemplate, separator, 'pip'), 0, min(length(replace(resourceNameTemplate, separator, 'pip')), 80))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'pip'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'pip')), 80))
    prefix: 'pip'
    maxLenght: 80
    scope: 'resourceGroup'
    dashes: true
  }
  publicIpPrefix: {
    refName: substring(replace(resourceNameTemplate, separator, 'ippre'), 0, min(length(replace(resourceNameTemplate, separator, 'ippre')), 80))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'ippre'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'ippre')), 80))
    prefix: 'ippre'
    maxLenght: 80
    scope: 'resourceGroup'
    dashes: true
  }
  purviewService: {
    refName: substring(replace(resourceNameTemplate, separator, 'pview'), 0, min(length(replace(resourceNameTemplate, separator, 'pview')), 63))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'pview'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'pview')), 63))
    prefix: 'pview'
    maxLenght: 63
    scope: 'resourceGroup'
    dashes: true
  }
  redisCache: {
    refName: substring(replace(resourceNameTemplate, separator, 'redis'), 0, min(length(replace(resourceNameTemplate, separator, 'redis')), 63))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'redis'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'redis')), 63))
    prefix: 'redis'
    maxLenght: 63
    scope: 'global'
    dashes: true
  }
  redisFirewallRule: {
    refName: substring(replace(resourceNameTemplateNoDashes, separator, 'redisfw'), 0, min(length(replace(resourceNameTemplateNoDashes, separator, 'redisfw')), 256))
    uniName: substring(replace(uniqueResourceNameTemplateNoDashes, separator, 'redisfw'), 0, min(length(replace(uniqueResourceNameTemplateNoDashes, separator, 'redisfw')), 256))
    prefix: 'redisfw'
    maxLenght: 256
    scope: 'parent'
    dashes: false
  }
  resourceGroup: {
    refName: substring(replace(resourceNameTemplate, separator, 'rg'), 0, min(length(replace(resourceNameTemplate, separator, 'rg')), 90))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'rg'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'rg')), 90))
    prefix: 'rg'
    maxLenght: 90
    scope: 'subscription'
    dashes: true
  }
  route: {
    refName: substring(replace(resourceNameTemplate, separator, 'udr'), 0, min(length(replace(resourceNameTemplate, separator, 'udr')), 80))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'udr'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'udr')), 80))
    prefix: 'udr'
    maxLenght: 80
    scope: 'parent'
    dashes: true
  }
  routeTable: {
    refName: substring(replace(resourceNameTemplate, separator, 'rt'), 0, min(length(replace(resourceNameTemplate, separator, 'rt')), 80))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'rt'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'rt')), 80))
    prefix: 'rt'
    maxLenght: 80
    scope: 'resourceGroup'
    dashes: true
  }
  serviceFabricCluster: {
    refName: substring(replace(resourceNameTemplate, separator, 'sf'), 0, min(length(replace(resourceNameTemplate, separator, 'sf')), 23))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'sf'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'sf')), 23))
    prefix: 'sf'
    maxLenght: 23
    scope: 'region'
    dashes: true
  }
  serviceBusNamespace: {
    refName: substring(replace(resourceNameTemplate, separator, 'sb'), 0, min(length(replace(resourceNameTemplate, separator, 'sb')), 50))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'sb'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'sb')), 50))
    prefix: 'sb'
    maxLenght: 50
    scope: 'global'
    dashes: true
  }
  serviceBusQueue: {
    refName: substring(replace(resourceNameTemplate, separator, 'sbq'), 0, min(length(replace(resourceNameTemplate, separator, 'sbq')), 260))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'sbq'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'sbq')), 260))
    prefix: 'sbq'
    maxLenght: 260
    scope: 'parent'
    dashes: true
  }
  serviceBusTopic: {
    refName: substring(replace(resourceNameTemplate, separator, 'sbt'), 0, min(length(replace(resourceNameTemplate, separator, 'sbt')), 260))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'sbt'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'sbt')), 260))
    prefix: 'sbt'
    maxLenght: 260
    scope: 'parent'
    dashes: true
  }
  signalrService: {
    refName: substring(replace(resourceNameTemplate, separator, 'sigr'), 0, min(length(replace(resourceNameTemplate, separator, 'sigr')), 63))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'sigr'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'sigr')), 63))
    prefix: 'sigr'
    maxLenght: 63
    scope: 'global'
    dashes: true
  }
  sqlDatabase: {
    refName: substring(replace(resourceNameTemplate, separator, 'sqldb'), 0, min(length(replace(resourceNameTemplate, separator, 'sqldb')), 128))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'sqldb'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'sqldb')), 128))
    prefix: 'sqldb'
    maxLenght: 128
    scope: 'parent'
    dashes: true
  }
  sqlElasticpool: {
    refName: substring(replace(resourceNameTemplate, separator, 'sqlep'), 0, min(length(replace(resourceNameTemplate, separator, 'sqlep')), 128))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'sqlep'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'sqlep')), 128))
    prefix: 'sqlep'
    maxLenght: 128
    scope: 'parent'
    dashes: true
  }
  sqlFirewallRule: {
    refName: substring(replace(resourceNameTemplate, separator, 'sqlfw'), 0, min(length(replace(resourceNameTemplate, separator, 'sqlfw')), 128))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'sqlfw'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'sqlfw')), 128))
    prefix: 'sqlfw'
    maxLenght: 128
    scope: 'parent'
    dashes: true
  }
  sqlServer: {
    refName: substring(replace(resourceNameTemplate, separator, 'sql'), 0, min(length(replace(resourceNameTemplate, separator, 'sql')), 63))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'sql'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'sql')), 63))
    prefix: 'sql'
    maxLenght: 63
    scope: 'global'
    dashes: true
  }
  sqlServerManagedInstance: {
    refName: substring(replace(resourceNameTemplate, separator, 'sqlmi'), 0, min(length(replace(resourceNameTemplate, separator, 'sqlmi')), 63))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'sqlmi'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'sqlmi')), 63))
    prefix: 'sqlmi'
    maxLenght: 63
    scope: 'global'
    dashes: true
  }
  storageAccount: {
    refName: substring(replace(resourceNameTemplateNoDashes, separator, 'st'), 0, min(length(replace(resourceNameTemplateNoDashes, separator, 'st')), 24))
    uniName: substring(replace(uniqueResourceNameTemplateNoDashes, separator, 'st'), 0, min(length(replace(uniqueResourceNameTemplateNoDashes, separator, 'st')), 24))
    prefix: 'st'
    maxLenght: 24
    scope: 'global'
    dashes: true
  }
  subnet: {
    refName: substring(replace(resourceNameTemplate, separator, 'snet'), 0, min(length(replace(resourceNameTemplate, separator, 'snet')), 80))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'snet'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'snet')), 80))
    prefix: 'snet'
    maxLenght: 80
    scope: 'parent'
    dashes: true
  }
  timeSeriesInsightsEnvironment: {
    refName: substring(replace(resourceNameTemplate, separator, 'tsi'), 0, min(length(replace(resourceNameTemplate, separator, 'tsi')), 90))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'tsi'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'tsi')), 90))
    prefix: 'tsi'
    maxLenght: 90
    scope: 'resourceGroup'
    dashes: true
  }
  trafficManagerProfile: {
    refName: substring(replace(resourceNameTemplate, separator, 'traf'), 0, min(length(replace(resourceNameTemplate, separator, 'traf')), 63))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'traf'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'traf')), 63))
    prefix: 'traf'
  }
  virtualMachineLinux: {
    refName: substring(replace(resourceNameTemplate, separator, 'vm'), 0, min(length(replace(resourceNameTemplate, separator, 'vm')), 64))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'vm'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'vm')), 64))
    prefix: 'vm'
    maxLenght: 64
    scope: 'resourceGroup'
    dashes: true
  }
  virtualMachineWindows: {
    refName: substring(replace(resourceNameTemplate, separator, 'vm'), 0, min(length(replace(resourceNameTemplate, separator, 'vm')), 15))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'vm'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'vm')), 15))
    prefix: 'vm'
    maxLenght: 15
    scope: 'resourceGroup'
    dashes: true
  }
  virtualMachineScaleSetLinux: {
    refName: substring(replace(resourceNameTemplate, separator, 'vmss'), 0, min(length(replace(resourceNameTemplate, separator, 'vmss')), 64))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'vmss'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'vmss')), 64))
    prefix: 'vmss'
    maxLenght: 64
    scope: 'resourceGroup'
    dashes: true
  }
  virtualMachineScaleSetWindows: {
    refName: substring(replace(resourceNameTemplate, separator, 'vmss'), 0, min(length(replace(resourceNameTemplate, separator, 'vmss')), 15))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'vmss'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'vmss')), 15))
    prefix: 'vmss'
    maxLenght: 15
    scope: 'resourceGroup'
    dashes: true
  }
  virtualNetwork: {
    refName: substring(replace(resourceNameTemplate, separator, 'vnet'), 0, min(length(replace(resourceNameTemplate, separator, 'vnet')), 64))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'vnet'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'vnet')), 64))
    prefix: 'vnet'
    maxLenght: 64
    scope: 'resourceGroup'
    dashes: true
  }
  virtualNetworkGateway: {
    refName: substring(replace(resourceNameTemplate, separator, 'vgw'), 0, min(length(replace(resourceNameTemplate, separator, 'vgw')), 80))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'vgw'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'vgw')), 80))
    prefix: 'vgw'
    maxLenght: 80
    scope: 'resourceGroup'
    dashes: true
  }
  virtualNetworkPeering: {
    refName: substring(replace(resourceNameTemplate, separator, 'peer'), 0, min(length(replace(resourceNameTemplate, separator, 'peer')), 80))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'peer'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'peer')), 80))
    prefix: 'peer'
    maxLenght: 80
    scope: 'parent'
    dashes: true
  }
  virtualWan: {
    refName: substring(replace(resourceNameTemplate, separator, 'vwan'), 0, min(length(replace(resourceNameTemplate, separator, 'vwan')), 80))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'vwan'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'vwan')), 80))
    prefix: 'vwan'
    maxLenght: 80
    scope: 'resourceGroup'
    dashes: true
  }
  vpnGateway: {
    refName: substring(replace(resourceNameTemplate, separator, 'vpng'), 0, min(length(replace(resourceNameTemplate, separator, 'vpng')), 80))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'vpng'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'vpng')), 80))
    prefix: 'vpng'
    maxLenght: 80
    scope: 'resourceGroup'
    dashes: true
  }
  vpnGatewayConnection: {
    refName: substring(replace(resourceNameTemplate, separator, 'vnc'), 0, min(length(replace(resourceNameTemplate, separator, 'vnc')), 80))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'vnc'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'vnc')), 80))
    prefix: 'vnc'
    maxLenght: 80
    scope: 'parent'
    dashes: true
  }
  vpnSite: {
    refName: substring(replace(resourceNameTemplate, separator, 'vst'), 0, min(length(replace(resourceNameTemplate, separator, 'vst')), 80))
    uniName: substring(replace(uniqueResourceNameTemplate, separator, 'vst'), 0, min(length(replace(uniqueResourceNameTemplate, separator, 'vst')), 80))
    prefix: 'vst'
    maxLenght: 80
    scope: 'resourceGroup'
    dashes: true
  }
}
