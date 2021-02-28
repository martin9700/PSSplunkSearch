# Get-SplunkSearchJobList

## SYNOPSIS
This will list all of the jobs currently stored on the Splunk server (whether they are running or
not).

## SYNTAX

```
Get-SplunkSearchJobList [[-Filter] <String>] [<CommonParameters>]
```

## DESCRIPTION
Retrieve a list of jobs.
Output is limited to just enough to identify the job from the search
criteria.
Results can be piped into Get-SplunkSearchJob to get more detailed information about the
job.

## EXAMPLES

### EXAMPLE 1
```
Get-SplunkSearchJobList -Filter "*4740*"
```

This example will use Get-SplunkSearchJobList to find any jobs with the text 4740 (user locked out)
in the name field--name field is always the text of the full search.

## PARAMETERS

### -Filter
Use this parameter to filter the results as needed.
Supports wildcards.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
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

