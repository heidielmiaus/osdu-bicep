# Azure Private Dns Zones Module

This module deploys an Azure Private Dns Zones.

## Description

This module supports the following features.

- Private Link (Secure network)

## Parameters

| Name                                    | Type     | Required | Description                                                                                                                                                                                                                                                                   |
| :-------------------------------------- | :------: | :------: | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `tags`                                  | `object` | No      | Tags         | 
                                                                                                                                                            
| `name`                                  | `string` | No      | PrivateDnsZoneName  |
                                                                                                                                                                                                                                  
| `lock`                                  | `string` | No       | Optional. Specify the type of lock.                                                                                                                                                                                                                                          |
| `privateLinkSettings`                   | `object` | No       | Settings Required to Enable Private Link                                                                                                                                                                                                                                                                                                                                                     |

## Outputs

| Name | Type   | Description               |
| :--- | :----: | :------------------------ |
| id   | string | The resource ID.          |
| name | string | The name of the resource. |

## Examples

### Example 1

```bicep
module storage 'br:osdubicep.azurecr.io/public/private-dns-zone:1.0.4' = {
  name: 'PrivateDNSZoneModule'
  params: {
    name: 'privatelink.blob.core.windows.net'
    // Enable Private Link
    privateLinkSettings: {
      vnetId: network.outputs.id
      subnetId: network.outputs.subnetIds[0]
    }
  }
}
```