Function ValidateSplunk
{
    <#
    .SYNOPSIS
        Helper script to make sure a connection variable has been created
    #>
    [CmdletBinding()]
    Param ()

    If (-not (Get-Variable SplunkConnect -Scope Global -ErrorAction SilentlyContinue))
    {
        Write-Error "You have not connected to Splunk, please run Connect-Splunk" -ErrorAction Stop
    }
}