Function Get-SplunkSearchJob
{
    <#
    .SYNOPSIS
        Script to retrieve detailed information about a submitted search job
    .DESCRIPTION
        This script will retrieve detailed information about a search job you (or someone) has submitted.
        It does not retrieve any gathered results of the job.
    .PARAMETER sid
        This is the sid of the job.  You can use Get-SplunkSearchJobList to locate your job and get the
        sid.  The sid is also given when you run Start-SplunkSearch.
    .EXAMPLE
        Get-SplunkSearchJobList -Filter "*4740*" | Select-Object -First 1 | Get-SplunkSearchJob

        This example will use Get-SplunkSearchJobList to find any jobs with the text 4740 (user locked out)
        in the name field--name field is always the text of the full search.  If there are multiple returns it
        will filter to only the first one, then retrieve the detailed information from that job.
    .EXAMPLE
        Get-SplunkSearchJob -sid 123456789.12345

        This will retrieve the job information for the above sid.
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