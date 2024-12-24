function Get-RSSFeed {
    <#
    .SYNOPSIS

    Gets the 5 most recent rss feed items from the provided URL

    .DESCRIPTION

    Script takes in a provided URL and returns 5 feed items as a custom object, sorted by publication date.

    .PARAMETER

    .EXAMPLE

    Get-RSSFeed -Url http://powershellisfun.com/feed
    
    .NOTES
    #>
    TODO: Add Parameters & CmdletBinding
    TODO: Add support for reading RSS Feeds from csv file
    $numberofitems = '5'
    $total = foreach ($item in Invoke-RestMethod -Uri http://powershellisfun.com/feed ) {
        [PSCustomObject]@{
            'Publication date' = $item.pubDate
            Title              = $item.Title
            Link               = $item.Link
        }
    }
    
    $total | Sort-Object { $_."Publication Date" -as [datetime] } |  Select-Object -Last $numberofitems
}