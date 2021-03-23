<#
.LINK
https://devblogs.microsoft.com/scripting/ive-got-a-powershell-secret-adding-a-gui-to-scripts/
.SYNOPSIS
The script brings together the Windows Presentation Foundation and various .NET assemblies in order to render the graphical interface.

#>
[CmdletBinding()]

Param(

 [Parameter(Mandatory=$True,Position=0)]

 [string]$XamlPath

)

 

[xml]$Global:xmlWPF = Get-Content -Path $XamlPath

 

#Add WPF and Windows Forms assemblies

try{

 Add-Type -AssemblyName PresentationCore,PresentationFramework,WindowsBase,system.windows.forms

} catch {

 Throw "Failed to load Windows Presentation Framework assemblies."

}

 

#Create the XAML reader using a new XML node reader

$Global:xamGUI = [Windows.Markup.XamlReader]::Load((new-object System.Xml.XmlNodeReader $xmlWPF))

 

#Create hooks to each named object in the XAML

$xmlWPF.SelectNodes("//*[@Name]") | %{

 Set-Variable -Name ($_.Name) -Value $xamGUI.FindName($_.Name) -Scope Global

 }
