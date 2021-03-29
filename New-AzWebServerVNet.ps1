#Create a Virtual Network

#Variables
$RG = 'Tom-VNet'
$Location = 'centralus'
$VNetName = 'TestVNet00'

#Create a new resource group
New-AzResourceGroup -Name $RG -Location $Location

#Create the virtual network
$virtualNetwork = New-AzVirtualNetwork `
  -ResourceGroupName $RG `
  -Location $Location `
  -Name $VNetName `
  -AddressPrefix 10.0.0.0/16

#Create the subnets

Add-AzVirtualNetworkSubnetConfig `
  -Name websubnet `
  -AddressPrefix 10.0.1.0/24 `
  -VirtualNetwork $virtualNetwork


#Associate subnets to virtual network
$virtualNetwork = $virtualNetwork | Set-AzVirtualNetwork  

#Creates Nic
$ipConfig = New-AzNetworkInterfaceIpConfig -Name ipconfig1 -PrivateIpAddress 10.0.1.4 -SubnetId $virtualNetwork.Subnets[0].Id
$nic = New-AzNetworkInterface -Name nic1 -ResourceGroupName $RG -Location $Location -IpConfiguration $ipConfig

$virtualNetwork = $virtualNetwork | Set-AzVirtualNetwork  

$pubIP = New-AzPublicIpAddress -Name webpublicip -AllocationMethod Dynamic -ResourceGroupName $RG -Sku Basic -Location $Location -IpAddressVersion IPv4 -DomainNameLabel TomTestWeb
$nic = Set-AzNetworkInterfaceIpConfig -PublicIpAddressId $pubIP.Id -Name $ipConfig.Name -NetworkInterface $nic
$nic | Set-AzNetworkInterface
$virtualNetwork = $virtualNetwork | Set-AzVirtualNetwork  

$NSGName = 'webnsg'

#Create an NSG
$webnsg = New-AzNetworkSecurityGroup -Name $NSGName -ResourceGroupName $RG -Location $Location

#create a Rule

New-AzNetworkSecurityRuleConfig -Name $NSGName -Description "Allow HTTP" `
  -Access Allow `
  -Protocol Tcp `
  -Direction Inbound `
  -Priority 100 `
  -SourceAddressPrefix Internet -SourcePortRange * `
  -DestinationAddressPrefix * -DestinationPortRange 80

Set-AzNetworkSecurityGroup -NetworkSecurityGroup $webnsg


$NSGName = 'remotensg'


#Create an NSG
$remotensg = New-AzNetworkSecurityGroup -Name $NSGName -ResourceGroupName $RG -Location $Location

#create a Rule

New-AzNetworkSecurityRuleConfig -Name $NSGName -Description "allow ssh" `
  -Access Allow `
  -Protocol Tcp `
  -Direction Inbound `
  -Priority 100 `
  -SourceAddressPrefix Internet -SourcePortRange * `
  -DestinationAddressPrefix * -DestinationPortRange 22 

Add-AzVirtualNetworkSubnetConfig `
  -Name remotesubnet `
  -AddressPrefix 10.0.2.0/24 `
  -VirtualNetwork $virtualNetwork `
  -NetworkSecurityGroupId $remotensg.Id |
  Set-AzNetworkInterface



#Associate subnets to virtual network
$virtualNetwork = $virtualNetwork | Set-AzVirtualNetwork  

$cred = Get-Credential

$vmconfig = New-AzVMConfig -VMName webvm -VMSize Standard_B1ms 
$vmconfig = Set-AzVMOperatingSystem -VM $vmconfig -Credential $cred -Linux -ComputerName 'webvm'
$vmconfig = Add-AzVMNetworkInterface -VM $vmconfig -Id $nic.Id
New-AzVM -ResourceGroupName $RG  -Location $Location -Name webvm  -ImageName UbuntuLTS -VirtualNetworkName $VNetName -SubnetName 'websubnet' -Credential $cred
#Delete the Vnet
Remove-AzVirtualNetwork -Name $VNetName `
  -ResourceGroupName $RG 
