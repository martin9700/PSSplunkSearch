Function Start-SplunkSearch
{
    <##>
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$true)]
        [string]$Query,

        [Parameter(Mandatory=$false)]
        [datetime]$Start = ((Get-Date).AddDays(-1)),

        [Parameter(Mandatory=$false)]
        [datetime]$End = (Get-Date),

        [Parameter(Mandatory=$false)]
        [string]$Index,

        [Parameter(Mandatory=$false)]
        [int]$Count = 50
    )

    Begin {
        ValidateSplunk
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
        $Job = InvokeSplunkMethod @SearchSplat

        $SearchSplat = @{
            Uri    = "/services/search/jobs/$($Job.sid)"
            Method = "GET"
        }

        $Wait = 0
        Do {
            Start-Sleep -Seconds $Wait
            $GetJob = InvokeSplunkMethod @SearchSplat
            If (-not $Wait)
            {
                Write-Verbose "Title: $($GetJob.entry.content.request.search)   Start: $Start   End: $End" -Verbose
                $Wait = 8
            }
            Write-Verbose "Job ($($Job.sid)) status is $($GetJob.entry.content.dispatchstate) ($($GetJob.entry.content.runDuration))" -Verbose
        } Until ($GetJob.entry.content.dispatchstate -notmatch "parsing|running")

        $Top = [math]::Round($GetJob.entry.content.resultCount / $Count) - 1
        $OffsetCount = 0
        $RawData = ForEach ($Offset in (0..$Top))
        {
            $Uri ="/services/search/jobs/$($Job.sid)/results"
            If ($Offset -gt 0)
            {
                $OffsetCount += $Count
            }
            $RetrieveSplat = @{
                Uri = $Uri
                Body = @{
                    count  = $Count
                    offset = $OffsetCount
                }
            }
            $temp = InvokeSplunkMethod @RetrieveSplat
            Write-Output $Temp.results
        }
        $Data = $RawData
        $Data | Add-Member -MemberType ScriptProperty -Name "Date" -Value { Get-Date $this._time }
        Write-Output $Data
    }
}