function Get-WindowsOEMProductKey {
    <#
    .SYNOPSIS
    Get the Windows OEM Product Key from the BIOS

    .DESCRIPTION
    This function retrieves the Windows OEM Product Key from the BIOS.

    .PARAMETER
    None

    .EXAMPLE
    Get-WindowsOEMProductKey

    .NOTES
    #>
    $key = wmic path softwarelicensingservice get OA3xOriginalProductKey
    Write-Host $Key
}