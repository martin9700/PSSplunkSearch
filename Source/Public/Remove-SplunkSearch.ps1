Function Remove-SplunkSearch
{
    <#
    .SYNOPSIS
        Delete the search job
    .DESCRIPTION
        When you've retrieved the search results needed, you can remote the search and it's results from the
        server using this function.
    .PARAMETER sid
        This is the sid associated with your search job.
    .EXAMPLE
        Remove-SplunkSearch -sid 123456789.12345

        Removes the specified search job.
    .EXAMPLE
        Get-SplunkSearchJobList -Filter "*4740*" | Remove-SplunkSearch
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
    [CmdletBinding(SupportsShouldProcess=$true,
        ConfirmImpact="High")]
    Param (
        [Parameter(Mandatory=$true,
            ValueFromPipelineByPropertyName=$true)]
        [string]$sid,

        [switch]$Force
    )

    Begin {
        ValidateSplunk
        Write-Verbose -Message "Starting Remove-SplunkSearch"
    }

    Process {
        $Job = Get-SplunkSearchJob -sid $sid -ErrorAction Stop

        $DeleteSplat = @{
            Uri         = "/services/search/jobs/$sid"
            Method      = "DELETE"
            ErrorAction = "Stop"
        }

        If ($Force -or $PSCmdlet.ShouldProcess("Remove this Splunk job?", $Job.Name))
        {
            Invoke-SplunkMethod @DeleteSplat
        }
    }
}