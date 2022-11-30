targetScope = 'resourceGroup'



@description('Optional. Private DNS zone name.')
param resourceName  string

@description('Optional. Array of custom objects describing vNet links of the DNS zone. Each object should contain properties \'vnetResourceId\' and \'registrationEnabled\'. The \'vnetResourceId\' is a resource ID of a vNet to link, \'registrationEnabled\' (bool) enables automatic DNS registration in the zone for the linked vNet.')
param virtualNetworkLinks array = []

@description('Optional. The location of the PrivateDNSZone. Should be global.')
param location string = 'global'

@description('Optional. Array of role assignment objects that contain the \'roleDefinitionIdOrName\' and \'principalId\' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or its fully qualified ID in the following format: \'/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11\'.')
param roleAssignments array = []

@allowed([
  'CanNotDelete'
  'NotSpecified'
  'ReadOnly'
])
@description('Optional. Specify the type of lock.')
param lock string = 'NotSpecified'

@description('Optional.Tags.')
param tags object = {}



@description('Specifies the name of the private DNS Zone.')
var publicDNSZoneForwarder = 'blob.${environment().suffixes.storage}'
var privateDnsZoneName = resourceName == '' ? 'privatelink.${publicDNSZoneForwarder}' : resourceName


resource privateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: privateDnsZoneName
  location: location
  tags: tags
  properties: {}
}

module privateDnsZone_virtualNetworkLinks '.bicep/virtual_network_links.bicep' = [for (virtualNetworkLink, index) in virtualNetworkLinks: {
  name: '${deployment().name}-${privateDnsZone.name}-${index}'
  params: {
    privateDnsZoneName: privateDnsZone.name
    name: contains(virtualNetworkLink, 'name') && !empty(virtualNetworkLink.name) ? virtualNetworkLink.name : '${last(split(virtualNetworkLink.virtualNetworkResourceId, '/'))}_link_to_vnet'
    virtualNetworkResourceId: virtualNetworkLink.virtualNetworkResourceId
    location: contains(virtualNetworkLink, 'location') && !empty(virtualNetworkLink.location) ? virtualNetworkLink.location : 'global'
    registrationEnabled: contains(virtualNetworkLink, 'registrationEnabled') && !empty(virtualNetworkLink.registrationEnabled) ? virtualNetworkLink.registrationEnabled : false
    tags: contains(virtualNetworkLink, 'tags') ? virtualNetworkLink.tags : {}
  }
}]


// Apply Resource Lock
resource resource_lock 'Microsoft.Authorization/locks@2017-04-01' = if (lock != 'NotSpecified') {
  name: '${privateDnsZone.name}-${lock}-lock'
  properties: {
    level: lock
    notes: lock == 'CanNotDelete' ? 'Cannot delete resource or child resources.' : 'Cannot modify the resource or child resources.'
  }
  scope: privateDnsZone
}

module privateDnsZone_roleAssignments '.bicep/nested_rbac.bicep' = [for (roleAssignment, index) in roleAssignments: {
  name: '${deployment().name}-rbac-${index}'
  params: {
    description: contains(roleAssignment, 'description') ? roleAssignment.description : ''
    principalIds: roleAssignment.principalIds
    principalType: contains(roleAssignment, 'principalType') ? roleAssignment.principalType : ''
    roleDefinitionIdOrName: roleAssignment.roleDefinitionIdOrName
    condition: contains(roleAssignment, 'condition') ? roleAssignment.condition : ''
    delegatedManagedIdentityResourceId: contains(roleAssignment, 'delegatedManagedIdentityResourceId') ? roleAssignment.delegatedManagedIdentityResourceId : ''
    resourceId: privateDnsZone.id
  }
}]



@description('The resource group the private DNS zone was deployed into.')
output resourceGroupName string = resourceGroup().name

@description('The name of the private DNS zone.')
output name string = privateDnsZone.name

@description('The resource ID of the private DNS zone.')
output id string = privateDnsZone.id

@description('The location the resource was deployed into.')
output location string = privateDnsZone.location


