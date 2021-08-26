$Increment = INC
Get-ChildItem | Where Name -match '^(\d+)(.+)$' |
    Select FullName,
        @{ N = 'Index'    ; E = { [Int]$Matches[1] }},
        @{ N = 'NameText' ; E = { $Matches[2] }} |
Sort Index -Descending | ForEach{    
    Rename-Item $_.FullName -NewName ( '{0:d2}{1}' -f ( $_.Index + $Increment ), $_.NameText )
}