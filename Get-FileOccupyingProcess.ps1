
<#
.SYNOPSIS
    Finds all processes accessing a file
.DESCRIPTION
    Returns all process object where the Process.CommandLine -contains $FileInfo.Name
.EXAMPLE
    C:\PS> Get-Item "example.txt" | Get-FileOccupyingProcess
.PARAMETER fileinfo
    The file or directorie who's file content you wish to search through
.OUTPUTS
    System.Diagnostics.Process of processes with file name in CommandLine propert
.NOTES
    General notes
#>
function Get-FileOccupyingProcess {
    [CmdletBinding()]
    param (
        #path to DeviceController EAR, by default it searches the working directory
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateScript( {
                if (-Not ($_ | Test-Path) ) {
                    throw "File or folder does not exist"
                }
                if (-Not ($_ | Test-Path -PathType Leaf) ) {
                    throw "The Path argument must be a file. Folder paths are not allowed."
                }
                return $true 
            })]
        [Alias("file")]
        [System.IO.FileSystemInfo[]]
        $FileInfo = (Get-ChildItem (Get-Location))
    )
    
    begin {
    }
    
    process {
        Get-Process|ForEach-Object -Parallel {
          if($_.CommandLine -match $FileInfo.Name)
            {$_}
        }
    }
    end {
    }
}



