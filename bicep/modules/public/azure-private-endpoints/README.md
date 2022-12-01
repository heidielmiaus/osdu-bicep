# Azure Storage Module

This module deploys a private endpoint.

## Description

This module supports the following features.

- serviceResourceId(for example, existing storageAccount)
- Private Link (Secure network)
- privateDnsZone(existing privateDnsZone(s))

## Parameters

| Name                                    | Type     | Required | Description                                                                                                                                                                                                                                                                   |
| :-------------------------------------- | :------: | :------: | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `resourceName`                          | `string` | Yes      | Used to name  allresources                                                                                                                                                                  |
| `subnetResourceId`                              | `string` | Yes       | Resource ID of the subnet.                                                                                                                                                                                                                                                            |
| `serviceResourceId`                                  | `string` | Yes       | Resource ID of the resource that needs to be connected to the network.                                                                                                                                                                                                                                                                         |
| `groupIds`                                  | `array` | Yes       |  Subtype(s) of the connection to be created.                                                                                                                                                                                                                                           |
| `applicationSecurityGroups`                              | `array` | No       | Application security groups in which the private endpoint IP configuration is included.                                                                                                                                                                                                                                                            |
| `customNetworkInterfaceName`                                  | `string` | No       | The custom name of the network interface attached to the private endpoint..                                                                                                                                                                                                                                                                         |
| `ipConfigurations`                                  | `array` | No       | A list of IP configurations of the private endpoint.                                                                                                                                                                                                                                          |
| `privateDnsZoneGroup`                                   | `object` | No       | The private DNS zone group configuration used to associate the private.                                                                                                 |                                                                                                                                                                                 
| `location`                   | `string` | No       | Location for all Resources  |                                                                                    

| `roleAssignments`                                  | `array` | No       | Array of role assignment objects.                                                                                                                                                                                             |                                                                            |
| `lock`                                  | `string` | No       | Optional. Specify the type of lock.                                                                                                                                                                                                                                           |
| `tags`                                  | `object` | No       | Optional. Specify the tags.                                                                                                                                                                                                                                           |
| `lock`                                  | `string` | No       | Optional. Specify the type of lock.                                                                                                                                                                                                                                           |

| `customDnsConfigs`                                   | `array` | No       | Specifies the Custom DNS configurations.                                                                                                                                                                                                                                                                                                                                                                              |
| `manualPrivateLinkServiceConnections`                   | `array` | No       |  Manual PrivateLink Service Connections                                                                                                                                                                                            |

## Outputs

| Name | Type   | Description               |
| :--- | :----: | :------------------------ |
| resourceGroupName   | string | The resource group the private endpoint was deployed into.          |
| resourceId | string | The resource ID of the private endpoint. |
| location   | string | The location the resource was deployed into.          |
| name | string | The name of the resource. |

## Examples

### Example 1

```bicep
module privateEndpoint 'br:osdubicep.azurecr.io/public/privateEndpoints:1.0.4' = {
  name: 'private-endpoint'
  params: {
    resourceName: privateEndpointName
    subnetResourceId: network.outputs.subnetIds[0]
    serviceResourceId: storage.outputs.resourceIds
    groupIds: ["blobs"]
  }
}
```

