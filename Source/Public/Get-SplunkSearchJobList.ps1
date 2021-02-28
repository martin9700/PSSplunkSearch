Function Get-SplunkSearchJobList
{
    <#
    .SYNOPSIS
        This will list all of the jobs currently stored on the Splunk server (whether they are running or
        not).
    .DESCRIPTION
        Retrieve a list of jobs. Output is limited to just enough to identify the job from the search
        criteria. Results can be piped into Get-SplunkSearchJob to get more detailed information about the
        job.
    .PARAMETER Filter
        Use this parameter to filter the results as needed. Supports wildcards.
    .EXAMPLE
        Get-SplunkSearchJobList -Filter "*4740*"

        This example will use Get-SplunkSearchJobList to find any jobs with the text 4740 (user locked out)
        in the name field--name field is always the text of the full search.
    .NOTES
        Author:             Martin Pugh
        Twitter:            @thesurlyadm1n
        Spiceworks:         Martin9700
        Blog:               www.thesurlyadmin.com

        Changelog:
            02/27/21        Initial Release
    .LINK
        https://github.com/martin9700/PSSplunkSearch
    #>
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$false,
            Position=0)]
        [string]$Filter
    )

    Begin {
        ValidateSplunk
        Write-Verbose -Message "Starting Get-SplunkSearchJobList"
    }

    Process {
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
}