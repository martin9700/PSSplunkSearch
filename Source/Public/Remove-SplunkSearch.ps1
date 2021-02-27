Function Remove-SplunkSearch
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
        Write-Verbose -Message "Starting Remove-SplunkSearch"
    }

    Process {
        $DeleteSplat = @{
            Uri         = "/services/search/jobs/$sid"
            Method      = "DELETE"
            ErrorAction = "Stop"
        }

        Invoke-SplunkMethod @DeleteSplat
    }
}