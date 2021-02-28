Function Receive-SplunkSearch
{
    <#
    .SYNOPSIS
        Use this to retrieve results from your completed Splunk search
    .DESCRIPTION
        This function is used to retrieve the search results from the designated search you created.
    .PARAMETER sid
        This is the sid associated with your search job.
    .PARAMETER ReceiveCount
        Default is 250 items.

        With larger queries you can get hundreds, if not thousands of results. To not kill your Splunk
        server this function limits the number items that can be retrieved by any single API call. This
        is being done in the background and you will get all results as output of this function.
    .EXAMPLE
        Start-SplunkSearch -Query "EventCode=4740" | Wait-SplunkSearch | Receive-SplunkSearch

        Starts a search looking for event id 4740, waits for the job to complete and then retrieves the results
    .EXAMPLE
        Get-SplunkSearchJobList -Filter "*4740*" | Receive-SplunkSearch
    .EXAMPLE
        Receive-SplunkSearch -sid 123456789.12345
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
        [string]$sid,

        [int]$ReceiveCount = 250
    )

    Begin {
        ValidateSplunk
        Write-Verbose -Message "Starting Receive-SplunkSearch"
    }

    Process {
        $GetJob = Get-SplunkSearchJob -sid $sid

        $Top = 0
        If ($GetJob.resultCount -gt $ReceiveCount)
        {
            $Top = [math]::Ceiling($GetJob.resultCount / $ReceiveCount) - 1
        }
        $OffsetCount = 0
        $Data = ForEach ($Offset in (0..$Top))
        {
            If ($Offset -gt 0)
            {
                $OffsetCount += $ReceiveCount
            }
            $RetrieveSplat = @{
                Uri  = "/services/search/jobs/$sid/results"
                Body = @{
                    count  = $ReceiveCount
                    offset = $OffsetCount
                }
            }
            Invoke-SplunkMethod @RetrieveSplat | Select-Object -ExpandProperty results
        }
        $Data | Add-Member -MemberType ScriptProperty -Name "Date" -Value { Get-Date $this._time }
        Write-Output $Data
    }
}