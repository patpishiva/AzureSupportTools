###################################################
#Author shiva patpi
#Date 10/7/2020
#Description: Under a given Azure Subscription 
#if you want to list out all the VMs and it's corresponding disk
#If you want to find out whether a VM is using Managed disk or Unmanaged disk

##################################################

function LogToFile()
{
}

#Module to display details on screen
function LogToConsole($output , $color)
{ 
 write-host $output -ForegroundColor $color 
}


#Below module will list out all the Virtual Machines which are using Managed and UnManaged Disks
#output format will be VMName , ManagedOrUnManaged
Function ListAllVMsUsingManagedDisks_And_UnManagedDisks()
{
    #login to Azure Account
    $login = Login-AzureRmAccount
    #If we have multiple subscriptions , select the required subID
    Set-AzureRmContext -SubscriptionName $login.Context.Subscription.Name
    #Get all Azure VMs under the subscription
    $AllVMs = Get-AzureRmVM
    #Loop through each subscription
    foreach($vm in $AllVMs)
    {
     #Get the particular VM Instance
     $vmInstance = Get-AzureRmVM -Name $vm.Name -ResourceGroupName $vm.ResourceGroupName
     #Check the StorageProfile Property called OSDisk
     if ( $vmInstance.StorageProfile.OsDisk.ManagedDisk -eq $null )
     {
      LogToConsole $("VMName:"+$vm.Name , "DiskType:"+"UnManagedDisk") "Cyan"
     }
     else
     {
      LogToConsole $("VMName:"+$vm.Name , "DiskType:"+"ManagedDisk")  "Green"
     }

    }
}


ListAllVMsUsingManagedDisks_And_UnManagedDisks
