targetScope = 'resourceGroup'

@description('PrivateDNSZone name.')
param name string



@description('Settings Required to Enable Private Link')
param privateLinkSettings object = {
  subnetId: '1' // Specify the Subnet for Private Endpoint
  vnetId: '1'  // Specify the Virtual Network for Virtual Network Link
}


//  Module --> Create a Private DNS zone
module privatednszone '../main.bicep' = {
  name: 'privateDNSZone'
  params: {
    privateLinkSettings: privateLinkSettings
    name: name
  }
}
