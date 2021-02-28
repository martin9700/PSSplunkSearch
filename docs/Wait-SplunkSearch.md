# Wait-SplunkSearch

## SYNOPSIS
Wait for a search result job to finish

## SYNTAX

```
Wait-SplunkSearch [-sid] <String> [<CommonParameters>]
```

## DESCRIPTION
You can use this function to watch a running search job until it finishes.

## EXAMPLES

### EXAMPLE 1
```
Start-SplunkSearch -Query "EventCode=4740" Index="domain_controllers" -Start "2/20/21" -End "2/22/21" | Wait-SplunkSearch
```

Begins a search and waits for it to complete.

### EXAMPLE 2
```
Get-SplunkSearchJobList -Filter "*4740*" | Wait-SplunkSearch
```

If this filter returns multiple results, it will wait for the first one before moving on to the second and so on.

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

