function Get-PubIP {
    <#
    .SYNOPSIS

    Clean up browser data for popular browsers

    .DESCRIPTION

    Find paths to browser data on a Windows computer and deletes it

    .PARAMETER 

    .INPUTS

    None

    .OUTPUTS

    .EXAMPLE

    .NOTES

    #>
    $PubIP = Invoke-WebRequest ifconfig.me/ip

    Write-Host "Public IP: $PubIP"
}