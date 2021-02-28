Function Start-SplunkSearch
{
    <#
    .SYNOPSIS
        Start a search job on your Splunk server
    .DESCRIPTION
        This will start a search job on your Splunk server, returning just the sid number of that job.
        Use Wait-SplunkSearch to watch the job until it finishes, and then Receive-SplunkSearch to
        retrieve the results.
    .PARAMETER Query
        This is the query (using Splunk's query language) for your search
    .PARAMETER Start
        Start time of your search. To keep you from overwhelming your server this defaults to 1 day
        ago.
    .PARAMETER End
        End time of your search. By default this will be now.
    .PARAMETER Index
        Specify the index you wish to search. This is an optional parameter and you could include the
        index in your Query if you wanted to.
    .EXAMPLE
        Remove-SplunkSearch -sid 123456789.12345

        Removes the specified search job.
    .EXAMPLE
        Get-SplunkSearchJobList -Filter "*4740*" | Remove-SplunkSearch
    .NOTES
        Author:         Martin Pugh
        Twitter:        @martin9700
        Spiceworks:     Martin9700
        Blog:           www.thesurlyadmin.com

        Changelog:
            02/27/21    Initial Release
    .LINK
        https://github.com/martin9700/PSSplunkSearch
    #>
    [CmdletBinding()]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseShouldProcessForStateChangingFunctions", "")]
    Param (
        [Parameter(Mandatory=$true)]
        [string]$Query,

        [Parameter(Mandatory=$false)]
        [datetime]$Start = ((Get-Date).AddDays(-1)),

        [Parameter(Mandatory=$false)]
        [datetime]$End = (Get-Date),

        [Parameter(Mandatory=$false)]
        [string]$Index
    )

    Begin {
        ValidateSplunk
        Write-Verbose -Message "Starting Start-SplunkSearch"
    }

    Process {
        $Search = $Query

        If ($Index -and $Search -notmatch "index ?= ?")
        {
            $Search += " index=$Index"
        }

        $Body = @{
            search        = "search $Search"
            earliest_time = Get-Date $Start.ToUniversalTime() -Format "yyyy-MM-ddTHH:mm:ss"
            latest_time   = Get-Date $End.ToUniversalTime() -Format "yyyy-MM-ddTHH:mm:ss"
        }

        $SearchSplat = @{
            Uri    = "/services/search/jobs"
            Body   = $Body
            Method = "POST"
        }
        $Data = Invoke-SplunkMethod @SearchSplat

        [PSCustomObject]@{
            sid           = $Data.sid
            Search        = $Body.Search
            Earliest_Time = $Body.earliest_time
            Latest_Time   = $Body.latest_time
        }
    }
}
