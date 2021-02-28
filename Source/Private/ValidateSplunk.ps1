Function ValidateSplunk
{
    <#
    .SYNOPSIS
        Helper script to make sure a connection variable has been created
    #>
    [CmdletBinding()]
    Param ()

    If (-not (Get-Variable SplunkConnect -Scope Script -ErrorAction SilentlyContinue))
    {
        Write-Error "You have not connected to Splunk, please run Connect-Splunk" -ErrorAction Stop
    }
    ElseIf ($Script:SplunkConnect.Expires -lt (Get-Date))
    {
        Write-Error "Your Splunk connection has expired, please run Connect-Splunk again" -ErrorAction Stop
        Disconnect-Splunk
    }
}