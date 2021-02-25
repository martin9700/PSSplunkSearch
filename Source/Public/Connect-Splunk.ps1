Function Connect-Splunk
{
    <#
    #>
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$true,
            Position=0)]
        [string]$Server,

        [Parameter(Mandatory=$false,
            Position=1)]
        [int]$Port = 8089,

        [Parameter(Mandatory=$true)]
        [pscredential]$Credential
    )

    If ((-not (Get-Variable SplunkConnect -Scope Global -ErrorAction SilentlyContinue)) -or $Global:SplunkConnect.Expires -lt (Get-Date))
    {
        $AuthSplat = @{
            Uri             = "https://$($server):$port/services/auth/login"
            UseBasicParsing = $true
            Body            = "username=$($Credential.UserName);password=$($Credential.GetNetworkCredential().Password)"
            Method          = "Post"
            ContentType     = "application/x-www-form-urlencoded"
            ErrorAction     = "Stop"
        }

        Try {
            $Return = Invoke-RestMethod @AuthSplat
        }
        Catch {
            Write-Error "Unable to authenticate to Splunk ($server), error: $_"
        }

        $Header = @{
            Authorization = "Splunk $($Return.response.sessionKey)"
        }

        $Global:SplunkConnect = [PSCustomObject]@{
            BaseUri = "https://$($server):$port"
            Header  = $Header
            Expires = (Get-Date).AddHours(6)
        }
    }
    Else
    {
        Write-Verbose "Already have a valid connection to Splunk"
    }
}