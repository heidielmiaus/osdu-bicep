# Azure Private Dns Zones Module

This module deploys an Azure Private Dns Zones.

## Description

This module supports the following features.

- Private Link (Secure network)

## Parameters

| Name                                    | Type     | Required | Description                                                                                                                                                                                                                                                                   |
| :-------------------------------------- | :------: | :------: | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `tags`                                  | `object` | No      | Tags         | 
                                                                                                                                                            
| `resourceName`                                  | `string` | No      | PrivateDnsZoneName  |


| `virtualNetworkLinks`                                  | `array` | No      | Required to Enable Private Link   |

| `location`                                  | `string` | No      | location         |     


| `lock`                                  | `string` | No       | Optional. Specify the type of lock.  |
                                                                                                                                                                | `roleAssignments`                       | `array`  | No       | Optional. Array of objects that describe RBAC permissions, format { roleDefinitionResourceId (string), principalId (string), principalType (enum), enabled (bool) }. Ref: https://docs.microsoft.com/en-us/azure/templates/microsoft.authorization/roleassignments?tabs=bicep |                                                                                                                                                                                  |

## Outputs

| Name | Type   | Description               |
| :--- | :----: | :------------------------ |
| resourceGroupName   | string | The resource group the private DNS zone was deployed into.          |
| name | string | The name of the private DNS zone. |
| id   | string | The resource ID.          |
| location | string | The location of the resource. |

## Examples

### Example 1

```bicep
module storage 'br:osdubicep.azurecr.io/public/private-dns-zone:1.0.4' = {
  name: 'PrivateDNSZoneModule'
  params: {
    resourceName: 'privatelink.blob.core.windows.net'
    virtualNetworkLinks: [{
        "name": "",
        "virtualNetworkResourceId": "/subscriptions/8c7ece7c-856a-44a8-a8a6-179eee92d5c5/resourceGroups/osdubicep-testing/providers/Microsoft.Network/virtualNetworks/vnet-centralspokevnetwgqaau2z3blgs0",
        "location": "global",
        "registrationEnabled": false,
        "tags": {
          "Environment": "Dev",
          "Project": "Tutorial"
        }
      }]
  }
}
```