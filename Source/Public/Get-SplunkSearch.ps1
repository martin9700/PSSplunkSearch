Function Get-SplunkSearch
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
        [string]$Index
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

        $Uri = "/services/search/jobs?earliest=1614056400&latesttime=1614229200"

        $Body = @{
            search = "search $Search"
        }

        $SearchSplat = @{
            Uri    = $Uri
            Body   = $Body
            Method = "POST"
        }
        $Job = InvokeSplunkMethod @SearchSplat

        $SearchSplat = @{
            Uri    = "/services/search/jobs/$($Job.sid)"
            Method = "GET"
        }

        $First = $true
        Do {
            $Data = InvokeSplunkMethod @SearchSplat
            If ($First)
            {
                Write-Verbose "Title: $($data.entry.content.request.search)" -Verbose
                $First = $false
            }
            Write-Verbose "Job ($($Job.sid)) status is $($Data.entry.content.dispatchstate) ($($Data.entry.content.runDuration))" -Verbose
            Start-Sleep -Seconds 8
        } Until ($Data.entry.content.dispatchstate -notmatch "parsing|running")

        $SearchSplat.Uri = "/services/search/jobs/$($Job.sid)/results"
        $Data = InvokeSplunkMethod @SearchSplat
        $Data
    }
}