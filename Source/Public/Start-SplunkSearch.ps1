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
        Write-Verbose -Message "Starting Start-SplunkSearch"

        If ($Count -ne $Global:SplunkConnect.Count)
        {
            $Global:SplunkConnect.ResultCount = $Count
        }
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
