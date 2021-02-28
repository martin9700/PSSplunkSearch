Function Wait-SplunkSearch
{
    <#
    .SYNOPSIS
        Wait for a search result job to finish
    .DESCRIPTION
        You can use this function to watch a running search job until it finishes.
    .PARAMETER sid
        This is the sid associated with your search job.
    .EXAMPLE
        Start-SplunkSearch -Query "EventCode=4740" Index="domain_controllers" -Start "2/20/21" -End "2/22/21" | Wait-SplunkSearch

        Begins a search and waits for it to complete.
    .EXAMPLE
        Get-SplunkSearchJobList -Filter "*4740*" | Wait-SplunkSearch

        If this filter returns multiple results, it will wait for the first one before moving on to the second and so on.
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
            ValueFromPipelineByPropertyName=$true)]
        [string]$sid
    )

    Begin {
        ValidateSplunk
        Write-Verbose -Message "Starting Wait-SplunkSearch"
    }

    Process {
        $SearchSplat = @{
            Uri         = "/services/search/jobs/$sid"
            Method      = "GET"
            ErrorAction = "Stop"
        }

        $Wait = 0
        Do {
            Start-Sleep -Seconds $Wait
            $GetJob = Invoke-SplunkMethod @SearchSplat
            If (-not $Wait)
            {
                $Start = Get-Date $GetJob.entry.content.request.earliest_time -Format "MM/dd/yyyy HH:mm:ss"
                $End   = Get-Date $GetJob.entry.content.request.latest_time -Format "MM/dd/yyyy HH:mm:ss"
                Write-Verbose "Title: $($GetJob.entry.content.request.search)   Start: $Start   End: $End"
                $Wait = 8
            }
            Write-Verbose "Job ($sid) status is $($GetJob.entry.content.dispatchState) ($($GetJob.entry.content.runDuration))"
        } Until ($GetJob.entry.content.isDone)

        [PSCustomObject]@{
            sid           = $sid
            Name          = $GetJob.entry.content.request.search
            Earliest_Time = $Start
            Latest_Time   = $End
            RunDuration   = $GetJob.entry.content.runDuration
            Status        = $GetJob.entry.content.dispatchState
        }
    }
}
