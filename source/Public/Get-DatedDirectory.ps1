function Get-DatedDirectory {
  <#
  .SYNOPSIS

  Returns the file path of a dated directory, based on a provided Target Directory.

  .DESCRIPTION

  Script accepts a target directory as a parameter and returns a string with the a dated sub-directory appended to the target directory. Script currently appends the current date as the subdirectory.

  .PARAMETER TargetDirectory

   The root file path for which a dated directory will be determined.

  .EXAMPLE

  Get-DatedDirectory -TargetDirectory 'C:\Temp' returns the string 'C:\Temp\MMddyyyy'

  .NOTES
  #>

  [CmdletBinding()]
  param(
    [Parameter(
      Mandatory = $true,
      HelpMessage = 'The end file path',
      ValueFromPipeline = $true,
      ValueFromPipelineByPropertyName = $true
    )]
    [string] $TargetDirectory
  )

  # Begin Block
  begin {
    [string] $CurrentDate = Get-Date -Format "MMddyyyy"
  }

  # Process Block
  process {
    [string] $TargetDatedDirectory = $TargetDirectory + '\' + $CurrentDate
  }

  # End Block
  end {
    return $TargetDatedDirectory
  }
}