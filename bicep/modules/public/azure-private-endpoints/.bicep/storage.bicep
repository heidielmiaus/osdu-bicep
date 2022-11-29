@minLength(3)
@maxLength(22)
@description('Used to name all resources')
param storageName string

resource storage 'Microsoft.Storage/storageAccounts@2022-05-01' existing = {
  name: storageName
}


@description('The resource ID.')
output id string = storage.id

@description('The name of the resource.')
output name string = storage.name
