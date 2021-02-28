Function Disconnect-Splunk
{
    <#
    .SYNOPSIS
        Script to delete the connection variable to Splunk
    .DESCRIPTION
        Script to delete the connection variable to Splunk
    .EXAMPLE
        Disconnect-Splunk
    .NOTES
        Author:         Martin Pugh
        Twitter:        @martin9700
        Spiceworks:     Martin9700
        Blog:           www.thesurlyadmin.com

        Changelog:
            02/27/21    Initial Release
    .LINK
        https://github.com/martin9700/PSSplunkSearch
    #>
    [CmdletBinding()]
    Param ()

    Process {
        Remove-Variable -Name SplunkConnect -Scope Script -ErrorAction SilentlyContinue
    }
}