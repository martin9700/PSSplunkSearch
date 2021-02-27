Function Wait-SplunkSearch
{
    <#
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
