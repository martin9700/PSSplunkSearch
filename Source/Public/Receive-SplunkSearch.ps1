Function Receive-SplunkSearch
{
    <#
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
        Write-Verbose -Message "Starting Receive-SplunkSearch"
    }

    Process {
        $GetJob = Get-SplunkSearchJob -sid $sid

        $Top = 0
        If ($GetJob.resultCount -gt $Global:SplunkConnect.ResultCount)
        {
            $Top = [math]::Ceiling($GetJob.resultCount / $Global:SplunkConnect.ResultCount) - 1
        }
        $OffsetCount = 0
        $Data = ForEach ($Offset in (0..$Top))
        {
            $Uri ="/services/search/jobs/$($Job.sid)/results"
            If ($Offset -gt 0)
            {
                $OffsetCount += $Global:SplunkConnect.ResultCount
            }
            $RetrieveSplat = @{
                Uri = $Uri
                Body = @{
                    count  = $Global:SplunkConnect.ResultCount
                    offset = $OffsetCount
                }
            }
            Invoke-SplunkMethod @RetrieveSplat | Select-Object -ExpandProperty results
        }
        $Data | Add-Member -MemberType ScriptProperty -Name "Date" -Value { Get-Date $this._time }
        Write-Output $Data
    }
}