function Set-TMServiceLogon {
    Param(
        [string]$ServiceName,
        [string[]]$ComputerName,
        [string]$NewPassword,
        [string]$NewUser,
        [string]$ErrorLogFilePath
    )

    ForEach ($computer in $ComputerName) {

        $option = New-CimSessionOption -Protocol Wsman
        $session = New-CimSession -SessionOption $option -ComputerName $Computer

        If ($PSBoundParameters.ContainsKey('NewUser')) {
            $args = @{'StartName'=$NewUser;
                      'StartPassword'=$NewPassword}
        } Else {
            $args = @{'StartPassword'=$NewPassword}
        }

        Invoke-CimMethod -ComputerName $computer -MethodName Change -Query "SELECT * FROM Win32_Service WHERE Name = '$ServiceName'" -Arguments $args |
        Select-Object -Property @{n='ComputerName';e={$computer}},@{n='Result';e={$_.ReturnValue}}

        $session | Remove-CimSession

    } #foreach
} #function
