Function Get-SplunkSearchJob
{
    <#
    #>
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$true,
            Position=0,
            ValueFromPipelineByPropertyName=$true)]
        [string]$sid
    )

    Begin {
        ValidateSplunk
        Write-Verbose -Message "Starting Get-SplunkSearchJob"
    }

    Process {
        $Splat = @{
            Uri = "/services/search/jobs/$sid"
        }
        $Result = Invoke-SplunkMethod @Splat
        $Data = $Result |
            Select-Object -ExpandProperty entry |
            Select-Object Id,Updated,Published,Author,Name
        $Content = $Result.entry.content

        $Properties = $Content | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name
        ForEach ($Property in $Properties)
        {
            $Data | Add-Member -MemberType NoteProperty -Name $Property -Value $Content.$Property
        }

        Write-Output $Data
    }
}