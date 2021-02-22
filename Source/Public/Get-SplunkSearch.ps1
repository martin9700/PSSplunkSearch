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
            $Search += " Index=$Index"
        }

        $Search += " earliest='$Start' latest='$End'"

        $Body = @{
            Search = "search $Search"
        }

        $SearchSplat = @{
            Uri  = "/services/search/jobs/export"
            Body = $Body
        }
        InvokeSplunkMethod @SearchSplat
    }
}