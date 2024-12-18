function Get-DatedDirectory {
    [string] $CurrentDate = Get-Date -Format "MMddyyyy"

    [string] $TargetDatedDirectory = $TargetDirectory + '\' + $CurrentDate

    return $TargetDatedDirectory
  }