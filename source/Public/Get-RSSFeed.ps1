function Get-RSSFeed {
    <#
    .SYNOPSIS

    .DESCRIPTION

    .PARAMETER 

    .EXAMPLE

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