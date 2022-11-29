targetScope = 'resourceGroup'

@minLength(3)
@maxLength(22)
@description('Used to name all resources')
param storageName string

@description('Used to name privateDNSZone')
param privateDnsZoneName string

@description('Settings Required to Enable Private Link')
param privateLinkSettings object = {
  subnetId: '1' // Specify the Subnet for Private Endpoint
  vnetId: '1'  // Specify the Virtual Network for Virtual Network Link
}


//  Module --> Create Storage Account
module privateEndpoint '../main.bicep' = {
  name: 'private_endpoint'
  params: {
    privateLinkSettings: privateLinkSettings
    storageName: storageName
    privateDnsZoneName: privateDnsZoneName
  }
}
