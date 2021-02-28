# Invoke-SplunkMethod

## SYNOPSIS
This makes the API calls to Splunk

## SYNTAX

```
Invoke-SplunkMethod [[-Uri] <String>] [[-Body] <Hashtable>] [[-Method] <String>] [<CommonParameters>]
```

## DESCRIPTION
Used by most of the functions within this module as a common way to make API calls to Splunk.
This
has been made available to the user in case you need to do some functions not currently covered by
the module.

## EXAMPLES

### EXAMPLE 1
```
Invoke-SplunkMethod -Uri "/services/search/jobs"
```

This would do a GET call to the "/services/search/jobs" endpoint.

## PARAMETERS

### -Uri
The Connect-Splunk function saves the server name and port of the Splunk server, so this would be
the full path after that.

Example:
    Full path: https://splunk.yourdomain.com:8089/services/search/jobs
    You would enter: /services/search/jobs

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

### -Body
Hashtable of parameters needed by the API endpoint. 
Make sure to follow the case set out in the
Splunk API reference, Splunk is case sensitive.

Example:
    @{
        offset = 50
        count  = 50
    }

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Method
Web method for the API endpoint. 
Must be "GET","POST","PUT" or "DELETE". 
GET is the default.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: GET
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

