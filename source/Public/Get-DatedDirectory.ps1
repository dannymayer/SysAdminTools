function Get-DatedDirectory {
  <#
  .SYNOPSIS

  .DESCRIPTION

  .PARAMETER 

  .EXAMPLE

  .NOTES
  #>
    [string] $CurrentDate = Get-Date -Format "MMddyyyy"

    [string] $TargetDatedDirectory = $TargetDirectory + '\' + $CurrentDate

    return $TargetDatedDirectory
  }