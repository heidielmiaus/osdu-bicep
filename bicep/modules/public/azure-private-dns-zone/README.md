# Azure Private DNS Zone Module

This module deploys an Azure Private DNS Zone.

## Description

This module supports the following features.

- Private Link (Secure network)

## Parameters

| Name                  | Type     | Required | Description                                                                                                                                                                                                                                                                                                                                                                                                     |
| :-------------------- | :------: | :------: | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `resourceName`        | `string` | Yes      | Optional. Private DNS zone name.                                                                                                                                                                                                                                                                                                                                                                                |
| `virtualNetworkLinks` | `array`  | No       | Optional. Array of custom objects describing vNet links of the DNS zone. Each object should contain properties 'vnetResourceId' and 'registrationEnabled'. The 'vnetResourceId' is a resource ID of a vNet to link, 'registrationEnabled' (bool) enables automatic DNS registration in the zone for the linked vNet.                                                                                            |
| `location`            | `string` | No       | Optional. The location of the PrivateDNSZone. Should be global.                                                                                                                                                                                                                                                                                                                                                 |
| `roleAssignments`     | `array`  | No       | Optional. Array of role assignment objects that contain the 'roleDefinitionIdOrName' and 'principalId' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or its fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'. |
| `lock`                | `string` | No       | Optional. Specify the type of lock.                                                                                                                                                                                                                                                                                                                                                                             |
| `tags`                | `object` | No       | Optional.Tags.                                                                                                                                                                                                                                                                                                                                                                                                  |

## Outputs

| Name              | Type   | Description                                                |
| :---------------- | :----: | :--------------------------------------------------------- |
| resourceGroupName | string | The resource group the private DNS zone was deployed into. |
| name              | string | The name of the private DNS zone.                          |
| id                | string | The resource ID of the private DNS zone.                   |
| location          | string | The location the resource was deployed into.               |

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