Function Invoke-SplunkMethod
{
    <#
    .SYNOPSIS
        This makes the API calls to Splunk
    .DESCRIPTION
        Used by most of the functions within this module as a common way to make API calls to Splunk. This
        has been made available to the user in case you need to do some functions not currently covered by
        the module.
    .PARAMETER Uri
        The Connect-Splunk function saves the server name and port of the Splunk server, so this would be
        the full path after that.

        Example:
            Full path: https://splunk.yourdomain.com:8089/services/search/jobs
            You would enter: /services/search/jobs
    .PARAMETER Body
        Hashtable of parameters needed by the API endpoint.  Make sure to follow the case set out in the
        Splunk API reference, Splunk is case sensitive.

        Example:
            @{
                offset = 50
                count  = 50
            }
    .PARAMETER Method
        Web method for the API endpoint.  Must be "GET","POST","PUT" or "DELETE".  GET is the default.
    .EXAMPLE
        Invoke-SplunkMethod -Uri "/services/search/jobs"

        This would do a GET call to the "/services/search/jobs" endpoint.
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
        [string]$Uri,
        [hashtable]$Body,
        [ValidateSet("GET","POST","PUT","DELETE")]
        [string]$Method = "GET"
    )

    Process {
        If ($Uri[0] -ne "/")
        {
            $Uri = "/$Uri"
        }

        $Uri = "$($Uri)?output_mode=json"

        $RestSplat = @{
            Uri             = "$($Script:SplunkConnect.BaseUri)$Uri"
            Header          = $Script:SplunkConnect.Header
            Method          = $Method
            Body            = $Body
            UseBasicParsing = $true
            Verbose         = $false
            ErrorAction     = "Stop"
        }
        Try {
            $Response = Invoke-RestMethod @RestSplat
        }
        Catch {
            Write-Error "Error retrieving query: $_"
            Return
        }

        # paging
        Return $Response
    }
}