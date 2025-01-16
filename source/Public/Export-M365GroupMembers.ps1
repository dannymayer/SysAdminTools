<#
    .SYNOPSIS
    Export-M365GroupMembers.ps1

    .DESCRIPTION
    Export Microsoft 365 Group Members to CSV file with PowerShell.

    .LINK
    www.alitajran.com/export-microsoft-365-group-members-to-csv-powershell/

    .NOTES
    Written by: ALI TAJRAN
    Website:    www.alitajran.com
    LinkedIn:   linkedin.com/in/alitajran

    .CHANGELOG
    V1.00, 03/18/2024 - Initial version
#>

# TODO: Paramatize $CsvPath
# CSV file path to export
$CsvPath = "C:\temp\M365GroupMembers.csv"

# Connect to Microsoft Graph with specified scopes
Connect-MgGraph -Scopes "User.Read.All", "Group.Read.All"

# Retrieve all groups
$groups = Get-MgGroup -All

# Get properties
$Properties = @(
    'Id', 'DisplayName', 'UserPrincipalName', 'UserType', 'AccountEnabled'
)

# Initialize a List to store the data
$Report = [System.Collections.Generic.List[Object]]::new()

# Set up the progress bar parameters
$totalGroups = $groups.Count
$currentGroup = 0

# Iterate through each group and retrieve group members
foreach ($group in $groups) {
    # Retrieve group members using the valid Group ID
    $members = Get-MgGroupMember -GroupId $group.id -All

    # Determine the group type
    $groupType = if ($group.groupTypes -eq "Unified" -and $group.securityEnabled) { "Microsoft 365 (security-enabled)" }
    elseif ($group.groupTypes -eq "Unified" -and !$group.securityEnabled) { "Microsoft 365" }
    elseif (!($group.groupTypes -eq "Unified") -and $group.securityEnabled -and $group.mailEnabled) { "Mail-enabled security" }
    elseif (!($group.groupTypes -eq "Unified") -and $group.securityEnabled) { "Security" }
    elseif (!($group.groupTypes -eq "Unified") -and $group.mailEnabled) { "Distribution" }
    else { "N/A" }

    # If there are no members, create an object with empty values
    if ($members.Count -eq 0) {
        $ReportLine = [PSCustomObject][ordered]@{
            GroupId            = $group.Id
            GroupDisplayName   = $group.DisplayName
            GroupType          = $groupType
            UserDisplayName    = "N/A"
            UserPrincipalName  = "N/A"
            UserAlias          = "N/A"
            UserType           = "N/A"
            UserAccountEnabled = "N/A"
        }
        # Add the report line to the List
        $Report.Add($ReportLine)
    }
    else {
        # Iterate through each group member and retrieve user details
        foreach ($member in $members) {
            $user = Get-MgUser -UserId $member.Id -Property $Properties -ErrorAction SilentlyContinue | Select-Object $Properties

            # Check if $user is not null before accessing properties
            if ($user.Count -ne 0) {
                # Extract the alias from the UserPrincipalName
                $alias = $user.UserPrincipalName.Split("@")[0]

                # Create an ordered custom object with properties in a specific order
                $ReportLine = [PSCustomObject][ordered]@{
                    GroupId            = $group.Id
                    GroupDisplayName   = $group.DisplayName
                    GroupType          = $groupType
                    UserDisplayName    = $user.DisplayName
                    UserPrincipalName  = $user.UserPrincipalName
                    UserAlias          = $alias
                    UserType           = $user.UserType
                    UserAccountEnabled = $user.AccountEnabled
                }

                # Add the report line to the List
                $Report.Add($ReportLine)
            }
        }
    }

    # Update the progress bar
    $currentGroup++
    $status = "{0:N0}" -f ($currentGroup / $totalGroups * 100)

    $progressParams = @{
        Activity        = "Retrieving Group Members"
        Status          = "Processing group: $($group.DisplayName) - $currentGroup of $totalGroups : $status% completed"
        PercentComplete = ($currentGroup / $totalGroups) * 100
    }

    Write-Progress @progressParams
}

# Complete the progress bar
Write-Progress -Activity "Retrieving Group Members" -Completed

# Export all user information to a CSV file
$Report | Sort-Object GroupDisplayName | Export-Csv $CsvPath -NoTypeInformation -Encoding utf8