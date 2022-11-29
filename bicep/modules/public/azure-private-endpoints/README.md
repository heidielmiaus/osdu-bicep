# Azure Storage Module

This module deploys a private endpoint.

## Description

This module supports the following features.

- StorageName(existing storageAccount's name)
- Private Link (Secure network)
- privateDnsZoneName(existing privateDnsZone's name)

## Parameters

| Name                                    | Type     | Required | Description                                                                                                                                                                                                                                                                   |
| :-------------------------------------- | :------: | :------: | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `storageName`                          | `string` | Yes      | Used to name all resources                                                                                                                                                                                                                                                    |
| `location`                              | `string` | No       | Resource Location.                                                                                                                                                                                                                                                            |
| `tags`                                  | `object` | No       | Tags.                                                                                                                                                                                                                                                                         |
| `lock`                                  | `string` | No       | Optional. Specify the type of lock.                                                                                                                                                                                                                                           |
| `privateDnsZoneName`                                   | `string` | No       | Specifies the private DNS Zone name.                                                                                                                                                                                                                                                                                                                                                                                  |
| `privateLinkSettings`                   | `object` | No       | Settings Required to Enable Private Link                                                                                                                                                                                                                                                                                      |

## Outputs

| Name | Type   | Description               |
| :--- | :----: | :------------------------ |
| id   | string | The resource ID.          |
| name | string | The name of the resource. |

## Examples

### Example 1

```bicep
module storage 'br:osdubicep.azurecr.io/public/privateEndpoints:1.0.4' = {
  name: 'storage_account'
  params: {
    privateLinkSettings: {
      vnetId: network.outputs.id
      subnetId: network.outputs.subnetIds[0]
    }
    storageName: storageName
    privateDnsZoneName: privateDnsZoneName
  }
}
```

