targetScope = 'resourceGroup'

@description('PrivateDNSZone name.')
param resourceName string



@description('custom objects describing vNet links of the DNS zone')
 param virtualNetworkLinks array = [
  {
    name: '1'
    virtualNetworkResourceId: '1'
    location: 'global'
    registrationEnabled: false
  }
 ]

//  Module --> Create a Private DNS zone
module privatednszone '../main.bicep' = {
  name: 'privateDnsZoneModule'
  params: {
    virtualNetworkLinks: virtualNetworkLinks
    resourceName: resourceName
  }
}
