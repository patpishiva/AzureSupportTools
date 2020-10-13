
function LogToFile()
{
}

#Module to display details on screen
function LogToConsole($output , $color)
{ 
 write-host $output -ForegroundColor $color 
}


#Below module will list out all the Virtual Machines which are using Managed and UnManaged Disks
Function ListAllUnManagedDisks()
{
    #initialize the subscriptionid
    $subID = "SubID"
    #login to Azure Account
    Connect-AzAccount
    #Get all Azure storage accounts under the subscription
    $AllStorageAccounts =  Get-AzStorageAccount
    #Loop through each storage account
    Write-Host "Looping through all the Storage Accounts under the subscription"
    foreach($stAcc in $AllStorageAccounts)
    {
     #Get the Storage account details under the resource group
     $strAccount = Get-AzStorageAccount -ResourceGroupName $stAcc.ResourceGroupName -Name $stAcc.StorageAccountName 
     #Get the context
     $context = $strAccount.Context
     #Get the Container
     $Containers = Get-AzStorageContainer -Context $context
     #Loop through all the containers
     foreach($container in $containers)
     {
      #Get all the blobs in the container
      $blobData = Get-AzStorageblob -Container $container.Name -Context $context 
      #Loop through the blobs
      foreach($blob in $blobData)
      {
      #Check if the blob has file with .vhd extension (any blob with extension .vhd considered as UnManaged disk)
      if ($blob.Name.ToString().Contains(".vhd"))
        {
            Write-host "StorageAccountName:"  $stAcc.StorageAccountName 
            Write-host "ContainerName:"  $container.Name 
            Write-host "BlobName:"  $blob.Name
        }
      }
     }

    }
}

ListAllUnManagedDisks



