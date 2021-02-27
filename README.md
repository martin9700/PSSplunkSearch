# PSSplunkSearch

## SYNOPSIS
	Use Start-SplunkSearch to submit your search to Splunk, and then retrive the results (see below).

## Installation
## ------------
Use the PowerShell Gallery to install PSSplunkSearch:

Install-Module PSSplunkSearch
Import-Module PSSplunkSearch


## Workflow Explanation
## --------------------
To run a Splunk search, you need to understand a little bit about how a the search mechanism works. Normally,
you would submit the search to Splunk, and that search would take place on the server (use Start-SplunkSearch).
When the job completes (use Wait-SplunkSearch to watch it) you can retrieve the results (use Receive-SplunkSearch).


## EXAMPLES
```powershell
Connect-Splunk -Server splunkserver.mydomain.com
$SearchJob = Start-SplunkSearch -Query "EventCode=4740" -Index "domain_controller" -Start "2/20/21" -End "2/21/22"
$SearchJob | Wait-SplunkSearch
$Data = $SearchJob | Receive-SplunkSearch
$SearchJob | Remove-SplunkSearch
```

This example would connect you to your Splunk server, then start a search for Windows Event ID 4740 (user locked out)
between the dates 2/20/21 and 2/21/22, using the "domain_controller" index.  It then will wait for the search to
complete, receive the search results (if any) to the variable $Data.  It then will remove the search job from the
Splunk server.
