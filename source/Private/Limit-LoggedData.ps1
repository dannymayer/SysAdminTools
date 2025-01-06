function Limit-LoggedData {
    <#
    .SYNOPSIS
    Steps to prepare the Commission File for conversion to .csv format
    
    .DESCRIPTION
    Function locates the commission file, creates a backup copy of the file, and renames it to 'commsm.txt'
    
    .PARAMETER LogFile

    .PARAMETER Message

    .PARAMETER Data

    .PARAMETER MaxSample

    .EXAMPLE
    
    Limit-LoggedData -LogFile $LogFile -Message "Sample Parsed Transaction:" -Data $_
    
    .NOTES
    General notes
    #>
    param (
        [string]$LogFile,
        [string]$Message,
        [array]$Data, # Collection of data to log
        [int]$MaxSample = 50 # Maximum number of records to log
    )
    try {
        # Add the message to the log
        Add-Content -Path $LogFile -Value $Message

        # If data is provided, log a limited sample
        if ($Data -and $Data.Count -gt 0) {
            $SampleData = $Data | Select-Object -First $MaxSample
            Add-Content -Path $LogFile -Value "Sample Data (`nShowing up to $MaxSample records):"
            Add-Content -Path $LogFile -Value ($SampleData | Out-String)
        } else {
            Add-Content -Path $LogFile -Value "No data available to log."
        }
    } catch {
        Write-Host "Failed to log data: $_"
    }
}