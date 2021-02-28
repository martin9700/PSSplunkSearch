# Connect-Splunk

## SYNOPSIS
Script to establish a connection to Splunk

## SYNTAX

```
Connect-Splunk [-Server] <String> [[-Port] <Int32>] -Credential <PSCredential> [<CommonParameters>]
```

## DESCRIPTION
Script to establish a connection to Splunk

## EXAMPLES

### EXAMPLE 1
```
Connect-Splunk -Server splunk.yourdomain.com
```

### EXAMPLE 2
```
Connect-Splunk -Server splunk.yourdomain.com -Port 9999
```

## PARAMETERS

### -Server
Name of the Splunk server

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

### -Port
Port number used by the Splunk server, default is 8089

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 8089
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
Username and password needed to authenticate

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
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

