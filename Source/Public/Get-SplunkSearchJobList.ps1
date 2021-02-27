Function Get-SplunkSearchJobList
{
    <#
    #>
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$false,
            Position=0)]
        [string]$Filter
    )

    $Splat = @{
        Uri         = "/services/search/jobs"
        ErrorAction = "Stop"
    }
    $Data = Invoke-SplunkMethod @Splat |
        Select-Object -ExpandProperty entry |
        Select-Object @{Name = "sid";Expression={ $_.content.sid}},
            @{Name = "Published";Expression={ Get-Date $_.published }},
            @{Name = "Name"; Expression={ $_.name}}

    If ($Filter)
    {
        $Data = $Data | Where-Object Name -like $Filter
    }

    Write-Output $Data
}