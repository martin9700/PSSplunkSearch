Function Disconnect-Splunk
{
    <#
    .SYNOPSIS
        Script to delete the connection variable to Splunk
    .EXAMPLE
        Disconnect-Splunk
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
    Param ()

    Process {
        Remove-Variable -Name SplunkConnect -Scope Script -ErrorAction SilentlyContinue
    }
}