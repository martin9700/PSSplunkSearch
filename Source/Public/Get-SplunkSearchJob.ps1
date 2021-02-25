Function Get-SplunkSearchJob
{
    <#
    #>
    [CmdletBinding(DefaultParameterSetName="name")]
    Param (
        [Parameter(Mandatory=$false,
            Position=0,
            ValueFromPipelineByPropertyName=$true,
            ParameterSetName="sid")]
        [string]$sid,

        [Parameter(Mandatory=$false,
            Position=0,
            ParameterSetName="name")]
        [string]$Name,

        [Parameter(Mandatory=$false,
            ParameterSetName="name")]
        [switch]$ExactMatch
    )

    Begin {
        ValidateSplunk
    }

    Process {
        If ($sid)
        {
            $Splat = @{
                Uri = "/services/search/jobs/$sid"
            }
            $Data = Invoke-SplunkMethod @Splat
            $Data
        }
        Else
        {
            $Splat = @{
                Uri = "/services/search/jobs"
            }
            $Data = Invoke-SplunkMethod @Splat |
                Select-Object -ExpandProperty entry |
                Select-Object @{Name = "sid";Expression={ $_.content.sid}},
                    @{Name = "Published";Expression={ Get-Date $_.published }},
                    @{Name = "Name"; Expression={ $_.name}}

            If ($Name)
            {
                If ($ExactMatch)
                {
                    $Search = "^$Name$"
                }
                Else
                {
                    $Search = $Name
                }
                $Data = $Data | Where-Object Name -match $Search
            }
            Write-Output $Data
        }
    }
}