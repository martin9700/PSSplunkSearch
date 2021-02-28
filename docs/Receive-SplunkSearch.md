# Receive-SplunkSearch

## SYNOPSIS
Use this to retrieve results from your completed Splunk search

## SYNTAX

```
Receive-SplunkSearch [-sid] <String> [-ReceiveCount <Int32>] [<CommonParameters>]
```

## DESCRIPTION
This function is used to retrieve the search results from the designated search you created.

## EXAMPLES

### EXAMPLE 1
```
Start-SplunkSearch -Query "EventCode=4740" | Wait-SplunkSearch | Receive-SplunkSearch
```

Starts a search looking for event id 4740, waits for the job to complete and then retrieves the results

### EXAMPLE 2
```
Get-SplunkSearchJobList -Filter "*4740*" | Receive-SplunkSearch
```

### EXAMPLE 3
```
Receive-SplunkSearch -sid 123456789.12345
```

## PARAMETERS

### -sid
This is the sid associated with your search job.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ReceiveCount
Default is 250 items.

With larger queries you can get hundreds, if not thousands of results.
To not kill your Splunk
server this function limits the number items that can be retrieved by any single API call.
This
is being done in the background and you will get all results as output of this function.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 250
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author:         Martin Pugh
Twitter:        @martin9700
Spiceworks:     Martin9700
Blog:           www.thesurlyadmin.com

Changelog:
    02/27/21    Initial Release

## RELATED LINKS

[https://github.com/martin9700/PSSplunkSearch](https://github.com/martin9700/PSSplunkSearch)

