targetScope = 'resourceGroup'

@minLength(3)
@maxLength(22)
@description('Required. Used to name all resources')
param resourceName string

@description('Required. Resource ID of the resource that needs to be connected to the network.')
param serviceResourceId string

@description('Required. Subtype(s) of the connection to be created. The allowed values depend on the type serviceResourceId refers to.')
param groupIds array


@description('Required. Resource ID of the subnet where the endpoint needs to be created.')
param subnetResourceId string

@description('Optional. The private DNS zone group configuration used to associate the private endpoint with one or multiple private DNS zones. A DNS zone group can support up to 5 DNS zones.')
param privateDnsZoneGroup object = {}

//  Module --> Create a PrivateEndpoint and privateEndpoints/privateDnsZoneGroups
module privateEndpoint '../main.bicep' = {
  name: 'privateEndpoint'
  params: {
    resourceName: resourceName
    subnetResourceId: subnetResourceId
    serviceResourceId: serviceResourceId
    groupIds: groupIds
    privateDnsZoneGroup: privateDnsZoneGroup
  }
}
