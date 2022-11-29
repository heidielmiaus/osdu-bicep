targetScope = 'resourceGroup'

@description('Tags.')
param tags object = {}

@description('PrivateDNSZone name.')
param name string


@allowed([
  'CanNotDelete'
  'NotSpecified'
  'ReadOnly'
])
@description('Optional. Specify the type of lock.')
param lock string = 'NotSpecified'



@description('Settings Required to Enable Private Link')
param privateLinkSettings object = {
  subnetId: '1' // Specify the Subnet for Private Endpoint
  vnetId: '1'  // Specify the Virtual Network for Virtual Network Link
}

var enablePrivateLink = privateLinkSettings.vnetId != '1' && privateLinkSettings.subnetId != '1'


@description('Specifies the name of the private DNS Zone.')
var publicDNSZoneForwarder = 'blob.${environment().suffixes.storage}'
var privateDnsZoneName = name == '' ? 'privatelink.${publicDNSZoneForwarder}' : name


resource privateDNSZone 'Microsoft.Network/privateDnsZones@2020-06-01' = if (enablePrivateLink) {
  name: privateDnsZoneName
  location: 'global'
  tags: tags
  properties: {}
}




// Apply Resource Lock
resource resource_lock 'Microsoft.Authorization/locks@2017-04-01' = if (lock != 'NotSpecified') {
  name: '${privateDNSZone.name}-${lock}-lock'
  properties: {
    level: lock
    notes: lock == 'CanNotDelete' ? 'Cannot delete resource or child resources.' : 'Cannot modify the resource or child resources.'
  }
  scope: privateDNSZone
}

@description('The resource ID.')
output id string = privateDNSZone.id

@description('The name of the resource.')
output name string = privateDNSZone.name


