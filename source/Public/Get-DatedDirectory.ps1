function Get-DatedDirectory {
  <#
  .SYNOPSIS

  Returns the file path of a dated directory

  .DESCRIPTION

  Script accepts a target directory as a parameter and returns a string with the a dated sub-directory appended to the target directory. Script currently appends the current date as the subdirectory.

  .PARAMETER 

  .EXAMPLE

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