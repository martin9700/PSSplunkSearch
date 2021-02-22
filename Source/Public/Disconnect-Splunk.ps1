Function Disconnect-Splunk
{
    <##>
    [CmdletBinding()]
    Param ()

    Process {
        Remove-Variable -Name SplunkConnect -Scope Global -ErrorAction SilentlyContinue
    }
}