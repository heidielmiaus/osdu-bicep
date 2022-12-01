@description('Conditional. The name of the parent private endpoint. Required if the template is used in a standalone deployment.')
param endpointName string

@description('Required. Array of private DNS zone resource IDs. A DNS zone group can support up to 5 DNS zones.')
@minLength(1)
@maxLength(5)
param dnsResourceIds array

@description('Optional. The name of the private DNS zone group.')
param resourceName string = 'default'


var privateDnsZoneConfigs = [for dnsResourceId in dnsResourceIds: {
  name: last(split(dnsResourceId, '/'))
  properties: {
    privateDnsZoneId: dnsResourceId
  }
}]

resource privateEndpoint 'Microsoft.Network/privateEndpoints@2022-05-01' existing = {
  name: endpointName
}

resource privateDnsZoneGroup 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2022-05-01' = {
  name: resourceName
  parent: privateEndpoint
  properties: {
    privateDnsZoneConfigs: privateDnsZoneConfigs
  }
}

@description('The name of the private endpoint DNS zone group.')
output name string = privateDnsZoneGroup.name

@description('The resource ID of the private endpoint DNS zone group.')
output resourceId string = privateDnsZoneGroup.id

@description('The resource group the private endpoint DNS zone group was deployed into.')
output resourceGroupName string = resourceGroup().name
