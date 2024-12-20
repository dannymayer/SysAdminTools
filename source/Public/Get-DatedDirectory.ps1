function Get-DatedDirectory {
  <#
  .SYNOPSIS

  .DESCRIPTION

  .PARAMETER 

  .EXAMPLE

  .NOTES
  #>
  # TODO Add Parameters & CmdletBinding

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