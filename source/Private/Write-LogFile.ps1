function Write-LogFile {
    <#
    .SYNOPSIS

    Creates a log file when called with varying degrees of severity

    .DESCRIPTION

    Creates a log file when called that can contain three levels of severity: Information, Warning, or Error.

    .PARAMETER Message

    .PARAMETER Severity

    .EXAMPLE

    $foo = $false
    if ($foo) {
        Write-Log -Message 'Foo was $true' -Severity Information
    } else {
        Write-Log -Message 'Foo was $false' -Severity Error
    }

    .NOTES

    Based on the Write-Log function from Adam the Automator - https://adamtheautomator.com/powershell-log-function/

    #>
    [CmdletBinding()]
    param(
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string] $Message,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('Information', 'Warning', 'Error')]
        [string] $Severity = 'Information'
    )

    begin {
        Write-Output 'Logging...'
    }

    process {
        # TODO: Paramatize csv Path and make write to csv optional
        $Log = [PSCustomObject]@{
            Time = (Get-Date -f g)
            Message = $Message
            Severity = $Severity
        } | Export-Csv -Path "$env:Temp\LogFile.csv" -Append -NoTypeInformation
    }

    end {
        Write-Output $Log
    }
}