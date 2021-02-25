Function InvokeSplunkMethod
{
    <#
    .SYNOPSIS
        Common invocation of splunk queries.
    #>
    [CmdletBinding()]
    Param (
        [string]$Uri,
        [hashtable]$Body,
        [string]$Method = "GET"
    )

    Process {
        If ($Uri[0] -ne "/")
        {
            $Uri = "/$Uri"
        }

        $Uri = "$($Uri)&output_mode=json"

        $RestSplat = @{
            Uri             = "$($Global:SplunkConnect.BaseUri)$Uri"
            Header          = $Global:SplunkConnect.Header
            Method          = $Method
            Body            = $Body
            UseBasicParsing = $true
            ErrorAction     = "SilentlyContinue"
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