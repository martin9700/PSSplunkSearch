# Get-SplunkSearchJob

## SYNOPSIS
Script to retrieve detailed information about a submitted search job

## SYNTAX

```
Get-SplunkSearchJob [-sid] <String> [<CommonParameters>]
```

## DESCRIPTION
This script will retrieve detailed information about a search job you (or someone) has submitted.
It does not retrieve any gathered results of the job.

## EXAMPLES

### EXAMPLE 1
```
Get-SplunkSearchJobList -Filter "*4740*" | Select-Object -First 1 | Get-SplunkSearchJob
```

This example will use Get-SplunkSearchJobList to find any jobs with the text 4740 (user locked out)
in the name field--name field is always the text of the full search. 
If there are multiple returns it
will filter to only the first one, then retrieve the detailed information from that job.

### EXAMPLE 2
```
Get-SplunkSearchJob -sid 123456789.12345
```

This will retrieve the job information for the above sid.

## PARAMETERS

### -sid
This is the sid of the job. 
You can use Get-SplunkSearchJobList to locate your job and get the
sid. 
The sid is also given when you run Start-SplunkSearch.

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

