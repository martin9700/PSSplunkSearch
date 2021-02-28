# Start-SplunkSearch

## SYNOPSIS
Start a search job on your Splunk server

## SYNTAX

```
Start-SplunkSearch [-Query] <String> [[-Start] <DateTime>] [[-End] <DateTime>] [[-Index] <String>]
 [<CommonParameters>]
```

## DESCRIPTION
This will start a search job on your Splunk server, returning just the sid number of that job.
Use Wait-SplunkSearch to watch the job until it finishes, and then Receive-SplunkSearch to
retrieve the results.

## EXAMPLES

### EXAMPLE 1
```
Remove-SplunkSearch -sid 123456789.12345
```

Removes the specified search job.

### EXAMPLE 2
```
Get-SplunkSearchJobList -Filter "*4740*" | Remove-SplunkSearch
```

## PARAMETERS

### -Query
This is the query (using Splunk's query language) for your search

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Start
Start time of your search.
To keep you from overwhelming your server this defaults to 1 day
ago.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: ((Get-Date).AddDays(-1))
Accept pipeline input: False
Accept wildcard characters: False
```

### -End
End time of your search.
By default this will be now.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: (Get-Date)
Accept pipeline input: False
Accept wildcard characters: False
```

### -Index
Specify the index you wish to search.
This is an optional parameter and you could include the
index in your Query if you wanted to.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
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

